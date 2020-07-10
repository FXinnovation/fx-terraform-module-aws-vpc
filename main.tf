terraform {
  required_version = ">= 0.11.3"
}

locals {
  max_subnet_length = "${max(length(var.private_subnets), length(var.private_extra_subnets), length(var.elasticache_subnets), length(var.database_subnets), length(var.redshift_subnets))}"
  nat_gateway_count = "${var.single_nat_gateway ? 1 : (var.one_nat_gateway_per_az ? length(var.azs) : local.max_subnet_length)}"

  vpc_id = "${element(concat(aws_vpc_ipv4_cidr_block_association.this.*.vpc_id, aws_vpc.this.*.id, list("")), 0)}"
}

######
# VPC
######

resource "aws_vpc" "this" {
  count = "${var.create_vpc ? 1 : 0}"

  cidr_block                       = "${var.cidr}"
  instance_tenancy                 = "${var.instance_tenancy}"
  enable_dns_hostnames             = "${var.enable_dns_hostnames}"
  enable_dns_support               = "${var.enable_dns_support}"
  assign_generated_ipv6_cidr_block = "${var.assign_generated_ipv6_cidr_block}"

  tags = "${merge(map("Name", format("%s", var.name)), var.tags, var.vpc_tags)}"
}

resource "aws_vpc_ipv4_cidr_block_association" "this" {
  count = "${var.create_vpc && length(var.secondary_cidr_blocks) > 0 ? length(var.secondary_cidr_blocks) : 0}"

  vpc_id = "${aws_vpc.this.id}"

  cidr_block = "${element(var.secondary_cidr_blocks, count.index)}"
}

###################
# DHCP Options Set
###################
resource "aws_vpc_dhcp_options" "this" {
  count = "${var.create_vpc && var.enable_dhcp_options ? 1 : 0}"

  domain_name          = "${var.dhcp_options_domain_name}"
  domain_name_servers  = ["${var.dhcp_options_domain_name_servers}"]
  ntp_servers          = ["${var.dhcp_options_ntp_servers}"]
  netbios_name_servers = ["${var.dhcp_options_netbios_name_servers}"]
  netbios_node_type    = "${var.dhcp_options_netbios_node_type}"

  tags = "${merge(map("Name", format("%s", var.name)), var.tags, var.dhcp_options_tags)}"
}

###############################
# DHCP Options Set Association
###############################
resource "aws_vpc_dhcp_options_association" "this" {
  count = "${var.create_vpc && var.enable_dhcp_options ? 1 : 0}"

  vpc_id          = "${local.vpc_id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.this.id}"
}

###################
# Internet Gateway
###################
resource "aws_internet_gateway" "this" {
  count = "${var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0}"

  vpc_id = "${local.vpc_id}"

  tags = "${merge(map("Name", format("%s", var.name)), var.tags, var.igw_tags)}"
}

################
# Publiс routes
################
resource "aws_route_table" "public" {
  count = "${var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0}"

  vpc_id = "${local.vpc_id}"

  tags = "${merge(map("Name", format("%s-${var.public_route_table_suffix}-%02d", var.name, count.index + 1)), var.tags, var.public_route_table_tags)}"
}

resource "aws_route" "public_internet_gateway" {
  count = "${var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0}"

  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.this.id}"

  timeouts {
    create = "5m"
  }
}

#################
# Private routes
# There are as many routing tables as the number of NAT gateways
#################
resource "aws_route_table" "private" {
  count = "${var.create_vpc && local.max_subnet_length > 0 ? local.nat_gateway_count : 0}"

  vpc_id = "${local.vpc_id}"

  tags = "${merge(map("Name", format("%s-${var.private_route_table_suffix}-%02d", var.name, count.index + 1)), var.tags, var.private_route_table_tags)}"

  lifecycle {
    ignore_changes = ["propagating_vgws"]
  }
}

####
# Private extra routes
# There are as many routing tables as the number of NAT gateways
####
resource "aws_route_table" "private_extra" {
  count = "${var.create_vpc && length(var.private_extra_subnets) > 0 && local.max_subnet_length > 0 ? local.nat_gateway_count : 0}"

  vpc_id = "${local.vpc_id}"

  tags = "${merge(map("Name", format("%s-${var.private_extra_route_table_suffix}-%02d", var.name, count.index + 1)), var.tags, var.private_extra_route_table_tags)}"

  lifecycle {
    ignore_changes = ["propagating_vgws"]
  }
}

resource "aws_route_table_association" "private_extra" {
  count = "${var.create_vpc && length(var.private_extra_subnets) > 0 ? length(var.private_extra_subnets) : 0}"

  subnet_id      = "${element(aws_subnet.private_extra.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private_extra.*.id, (var.single_nat_gateway ? 0 : count.index))}"
}

resource "aws_route" "private_extra_nat_gateway" {
  count = "${var.create_vpc && length(var.private_extra_subnets) > 0 && var.enable_nat_gateway ? local.nat_gateway_count : 0}"

  route_table_id         = "${element(aws_route_table.private_extra.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.this.*.id, count.index)}"

  timeouts {
    create = "5m"
  }
}

#################
# Database routes
#################
resource "aws_route_table" "database" {
  count = "${var.create_vpc && var.create_database_subnet_route_table && length(var.database_subnets) > 0 ? 1 : 0}"

  vpc_id = "${local.vpc_id}"

  tags = "${merge(map("Name", format("%s-${var.database_route_table_suffix}-%02d", var.name, count.index + 1)), var.tags, var.database_route_table_tags)}"
}

resource "aws_route" "database_internet_gateway" {
  count = "${var.create_vpc && var.create_database_subnet_route_table && length(var.database_subnets) > 0 && var.create_database_internet_gateway_route && ! var.create_database_nat_gateway_route ? 1 : 0}"

  route_table_id         = "${aws_route_table.database.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.this.id}"

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "database_nat_gateway" {
  count                  = "${var.create_vpc && var.create_database_subnet_route_table && length(var.database_subnets) > 0 && ! var.create_database_internet_gateway_route && var.create_database_nat_gateway_route && var.enable_nat_gateway ? local.nat_gateway_count : 0}"
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.this.*.id, count.index)}"

  timeouts {
    create = "5m"
  }
}

#################
# Redshift routes
#################
resource "aws_route_table" "redshift" {
  count = "${var.create_vpc && var.create_redshift_subnet_route_table && length(var.redshift_subnets) > 0 ? 1 : 0}"

  vpc_id = "${local.vpc_id}"

  tags = "${merge(map("Name", format("%s-${var.redshift_route_table_suffix}-%02d", var.name, count.index + 1)), var.tags, var.redshift_route_table_tags)}"
}

#################
# Elasticache routes
#################
resource "aws_route_table" "elasticache" {
  count = "${var.create_vpc && var.create_elasticache_subnet_route_table && length(var.elasticache_subnets) > 0 ? 1 : 0}"

  vpc_id = "${local.vpc_id}"

  tags = "${merge(map("Name", format("%s-${var.elasticache_route_table_suffix}-%02d", var.name, count.index + 1)), var.tags, var.elasticache_route_table_tags)}"
}

#################
# Intra routes
#################
resource "aws_route_table" "intra" {
  count = "${var.create_vpc && length(var.intra_subnets) > 0 ? 1 : 0}"

  vpc_id = "${local.vpc_id}"

  tags = "${merge(map("Name", format("%s-${var.intra_route_table_suffix}-%02d", var.name, count.index + 1)), var.tags, var.intra_route_table_tags)}"
}

################
# Public subnet
################
resource "aws_subnet" "public" {
  count = "${var.create_vpc && length(var.public_subnets) > 0 && (! var.one_nat_gateway_per_az || length(var.public_subnets) >= length(var.azs)) ? length(var.public_subnets) : 0}"

  vpc_id                  = "${local.vpc_id}"
  cidr_block              = "${element(concat(var.public_subnets, list("")), count.index)}"
  availability_zone       = "${element(var.azs, count.index)}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"

  tags = "${merge(map("Name", format("%s-${var.public_subnet_suffix}-%02d", var.name, count.index + 1)), var.tags, var.public_subnet_tags)}"
}

#################
# Private subnet
#################
resource "aws_subnet" "private" {
  count = "${var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0}"

  vpc_id            = "${local.vpc_id}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"

  tags = "${merge(map("Name", format("%s-${var.private_subnet_suffix}-%02d", var.name, count.index + 1)), var.tags, var.private_subnet_tags)}"
}

####
# Private extra subnet
####

resource "aws_subnet" "private_extra" {
  count = "${var.create_vpc && length(var.private_extra_subnets) > 0 ? length(var.private_extra_subnets) : 0}"

  vpc_id            = "${local.vpc_id}"
  cidr_block        = "${var.private_extra_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"

  tags = "${merge(map("Name", format("%s-${var.private_extra_subnet_suffix}-%02d", var.name, count.index + 1)), var.tags, var.private_extra_subnet_tags)}"
}

##################
# Database subnet
##################
resource "aws_subnet" "database" {
  count = "${var.create_vpc && length(var.database_subnets) > 0 ? length(var.database_subnets) : 0}"

  vpc_id            = "${local.vpc_id}"
  cidr_block        = "${var.database_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"

  tags = "${merge(map("Name", format("%s-${var.database_subnet_suffix}-%02d", var.name, count.index + 1)), var.tags, var.database_subnet_tags)}"
}

resource "aws_db_subnet_group" "database" {
  count = "${var.create_vpc && length(var.database_subnets) > 0 && var.create_database_subnet_group ? 1 : 0}"

  name        = "${lower(var.name)}"
  description = "Database subnet group for ${var.name}"
  subnet_ids  = ["${aws_subnet.database.*.id}"]

  tags = "${merge(map("Name", format("%s", var.name)), var.tags, var.database_subnet_group_tags)}"
}

##################
# Redshift subnet
##################
resource "aws_subnet" "redshift" {
  count = "${var.create_vpc && length(var.redshift_subnets) > 0 ? length(var.redshift_subnets) : 0}"

  vpc_id            = "${local.vpc_id}"
  cidr_block        = "${var.redshift_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"

  tags = "${merge(map("Name", format("%s-${var.redshift_subnet_suffix}-%02d", var.name, count.index + 1)), var.tags, var.redshift_subnet_tags)}"
}

resource "aws_redshift_subnet_group" "redshift" {
  count = "${var.create_vpc && length(var.redshift_subnets) > 0 && var.create_redshift_subnet_group ? 1 : 0}"

  name        = "${lower(var.name)}"
  description = "Redshift subnet group for ${var.name}"
  subnet_ids  = ["${aws_subnet.redshift.*.id}"]

  tags = "${merge(map("Name", format("%s", var.name)), var.tags, var.redshift_subnet_group_tags)}"
}

#####################
# ElastiCache subnet
#####################
resource "aws_subnet" "elasticache" {
  count = "${var.create_vpc && length(var.elasticache_subnets) > 0 ? length(var.elasticache_subnets) : 0}"

  vpc_id            = "${local.vpc_id}"
  cidr_block        = "${var.elasticache_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"

  tags = "${merge(map("Name", format("%s-${var.elasticache_subnet_suffix}-%02d", var.name, count.index + 1)), var.tags, var.elasticache_subnet_tags)}"
}

resource "aws_elasticache_subnet_group" "elasticache" {
  count = "${var.create_vpc && length(var.elasticache_subnets) > 0 && var.create_elasticache_subnet_group ? 1 : 0}"

  name        = "${var.name}"
  description = "ElastiCache subnet group for ${var.name}"
  subnet_ids  = ["${aws_subnet.elasticache.*.id}"]
}

#####################################################
# intra subnets - private subnet without NAT gateway
#####################################################
resource "aws_subnet" "intra" {
  count = "${var.create_vpc && length(var.intra_subnets) > 0 ? length(var.intra_subnets) : 0}"

  vpc_id            = "${local.vpc_id}"
  cidr_block        = "${var.intra_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"

  tags = "${merge(map("Name", format("%s-${var.intra_subnet_suffix}-%02d", var.name, count.index + 1)), var.tags, var.intra_subnet_tags)}"
}

#######################
# Default Network ACLs
#######################
resource "aws_default_network_acl" "this" {
  count = "${var.create_vpc && var.manage_default_network_acl ? 1 : 0}"

  default_network_acl_id = "${element(concat(aws_vpc.this.*.default_network_acl_id, list("")), 0)}"

  ingress = "${var.default_network_acl_ingress}"
  egress  = "${var.default_network_acl_egress}"

  tags = "${merge(map("Name", format("%s", var.default_network_acl_name)), var.tags, var.default_network_acl_tags)}"

  lifecycle {
    ignore_changes = ["subnet_ids"]
  }
}

########################
# Public Network ACLs
########################
resource "aws_network_acl" "public" {
  count = "${var.create_vpc && var.public_dedicated_network_acl && length(var.public_subnets) > 0 ? 1 : 0}"

  vpc_id     = "${element(concat(aws_vpc.this.*.id, list("")), 0)}"
  subnet_ids = ["${aws_subnet.public.*.id}"]

  tags = "${merge(map("Name", format("%s-${var.public_subnet_suffix}", var.name)), var.tags, var.public_acl_tags)}"
}

resource "aws_network_acl_rule" "public_inbound" {
  count = "${var.create_vpc && var.public_dedicated_network_acl && length(var.public_subnets) > 0 ? length(var.public_inbound_acl_rules) : 0}"

  network_acl_id = "${aws_network_acl.public.id}"

  egress      = false
  rule_number = "${lookup(var.public_inbound_acl_rules[count.index], "rule_number")}"
  rule_action = "${lookup(var.public_inbound_acl_rules[count.index], "rule_action")}"
  from_port   = "${lookup(var.public_inbound_acl_rules[count.index], "from_port")}"
  to_port     = "${lookup(var.public_inbound_acl_rules[count.index], "to_port")}"
  protocol    = "${lookup(var.public_inbound_acl_rules[count.index], "protocol")}"
  cidr_block  = "${lookup(var.public_inbound_acl_rules[count.index], "cidr_block")}"
}

resource "aws_network_acl_rule" "public_outbound" {
  count = "${var.create_vpc && var.public_dedicated_network_acl && length(var.public_subnets) > 0 ? length(var.public_outbound_acl_rules) : 0}"

  network_acl_id = "${aws_network_acl.public.id}"

  egress      = true
  rule_number = "${lookup(var.public_outbound_acl_rules[count.index], "rule_number")}"
  rule_action = "${lookup(var.public_outbound_acl_rules[count.index], "rule_action")}"
  from_port   = "${lookup(var.public_outbound_acl_rules[count.index], "from_port")}"
  to_port     = "${lookup(var.public_outbound_acl_rules[count.index], "to_port")}"
  protocol    = "${lookup(var.public_outbound_acl_rules[count.index], "protocol")}"
  cidr_block  = "${lookup(var.public_outbound_acl_rules[count.index], "cidr_block")}"
}

#######################
# Private Network ACLs
#######################
resource "aws_network_acl" "private" {
  count = "${var.create_vpc && var.private_dedicated_network_acl && length(var.private_subnets) > 0 ? 1 : 0}"

  vpc_id     = "${element(concat(aws_vpc.this.*.id, list("")), 0)}"
  subnet_ids = ["${aws_subnet.private.*.id}"]

  tags = "${merge(map("Name", format("%s-${var.private_subnet_suffix}", var.name)), var.tags, var.private_acl_tags)}"
}

resource "aws_network_acl_rule" "private_inbound" {
  count = "${var.create_vpc && var.private_dedicated_network_acl && length(var.private_subnets) > 0 ? length(var.private_inbound_acl_rules) : 0}"

  network_acl_id = "${aws_network_acl.private.id}"

  egress      = false
  rule_number = "${lookup(var.private_inbound_acl_rules[count.index], "rule_number")}"
  rule_action = "${lookup(var.private_inbound_acl_rules[count.index], "rule_action")}"
  from_port   = "${lookup(var.private_inbound_acl_rules[count.index], "from_port")}"
  to_port     = "${lookup(var.private_inbound_acl_rules[count.index], "to_port")}"
  protocol    = "${lookup(var.private_inbound_acl_rules[count.index], "protocol")}"
  cidr_block  = "${lookup(var.private_inbound_acl_rules[count.index], "cidr_block")}"
}

resource "aws_network_acl_rule" "private_outbound" {
  count = "${var.create_vpc && var.private_dedicated_network_acl && length(var.private_subnets) > 0 ? length(var.private_outbound_acl_rules) : 0}"

  network_acl_id = "${aws_network_acl.private.id}"

  egress      = true
  rule_number = "${lookup(var.private_outbound_acl_rules[count.index], "rule_number")}"
  rule_action = "${lookup(var.private_outbound_acl_rules[count.index], "rule_action")}"
  from_port   = "${lookup(var.private_outbound_acl_rules[count.index], "from_port")}"
  to_port     = "${lookup(var.private_outbound_acl_rules[count.index], "to_port")}"
  protocol    = "${lookup(var.private_outbound_acl_rules[count.index], "protocol")}"
  cidr_block  = "${lookup(var.private_outbound_acl_rules[count.index], "cidr_block")}"
}

####
# Private extra Network ACLs
####
resource "aws_network_acl" "private_extra" {
  count = "${var.create_vpc && var.private_extra_dedicated_network_acl && length(var.private_extra_subnets) > 0 ? 1 : 0}"

  vpc_id     = "${local.vpc_id}"
  subnet_ids = ["${aws_subnet.private_extra.*.id}"]

  tags = "${merge(map("Name", format("%s-${var.private_extra_subnet_suffix}", var.name)), var.tags, var.private_extra_acl_tags)}"
}

resource "aws_network_acl_rule" "private_extra_inbound" {
  count = "${var.create_vpc && var.private_extra_dedicated_network_acl && length(var.private_extra_subnets) > 0 ? length(var.private_extra_inbound_acl_rules) : 0}"

  network_acl_id = "${aws_network_acl.private_extra.id}"

  egress      = false
  rule_number = "${lookup(var.private_extra_inbound_acl_rules[count.index], "rule_number")}"
  rule_action = "${lookup(var.private_extra_inbound_acl_rules[count.index], "rule_action")}"
  from_port   = "${lookup(var.private_extra_inbound_acl_rules[count.index], "from_port")}"
  to_port     = "${lookup(var.private_extra_inbound_acl_rules[count.index], "to_port")}"
  protocol    = "${lookup(var.private_extra_inbound_acl_rules[count.index], "protocol")}"
  cidr_block  = "${lookup(var.private_extra_inbound_acl_rules[count.index], "cidr_block")}"
}

resource "aws_network_acl_rule" "private_extra_outbound" {
  count = "${var.create_vpc && var.private_extra_dedicated_network_acl && length(var.private_extra_subnets) > 0 ? length(var.private_extra_outbound_acl_rules) : 0}"

  network_acl_id = "${aws_network_acl.private_extra.id}"

  egress      = true
  rule_number = "${lookup(var.private_extra_outbound_acl_rules[count.index], "rule_number")}"
  rule_action = "${lookup(var.private_extra_outbound_acl_rules[count.index], "rule_action")}"
  from_port   = "${lookup(var.private_extra_outbound_acl_rules[count.index], "from_port")}"
  to_port     = "${lookup(var.private_extra_outbound_acl_rules[count.index], "to_port")}"
  protocol    = "${lookup(var.private_extra_outbound_acl_rules[count.index], "protocol")}"
  cidr_block  = "${lookup(var.private_extra_outbound_acl_rules[count.index], "cidr_block")}"
}

########################
# Intra Network ACLs
########################
resource "aws_network_acl" "intra" {
  count = "${var.create_vpc && var.intra_dedicated_network_acl && length(var.intra_subnets) > 0 ? 1 : 0}"

  vpc_id     = "${element(concat(aws_vpc.this.*.id, list("")), 0)}"
  subnet_ids = ["${aws_subnet.intra.*.id}"]

  tags = "${merge(map("Name", format("%s-${var.intra_subnet_suffix}", var.name)), var.tags, var.intra_acl_tags)}"
}

resource "aws_network_acl_rule" "intra_inbound" {
  count = "${var.create_vpc && var.intra_dedicated_network_acl && length(var.intra_subnets) > 0 ? length(var.intra_inbound_acl_rules) : 0}"

  network_acl_id = "${aws_network_acl.intra.id}"

  egress      = false
  rule_number = "${lookup(var.intra_inbound_acl_rules[count.index], "rule_number")}"
  rule_action = "${lookup(var.intra_inbound_acl_rules[count.index], "rule_action")}"
  from_port   = "${lookup(var.intra_inbound_acl_rules[count.index], "from_port")}"
  to_port     = "${lookup(var.intra_inbound_acl_rules[count.index], "to_port")}"
  protocol    = "${lookup(var.intra_inbound_acl_rules[count.index], "protocol")}"
  cidr_block  = "${lookup(var.intra_inbound_acl_rules[count.index], "cidr_block")}"
}

resource "aws_network_acl_rule" "intra_outbound" {
  count = "${var.create_vpc && var.intra_dedicated_network_acl && length(var.intra_subnets) > 0 ? length(var.intra_outbound_acl_rules) : 0}"

  network_acl_id = "${aws_network_acl.intra.id}"

  egress      = true
  rule_number = "${lookup(var.intra_outbound_acl_rules[count.index], "rule_number")}"
  rule_action = "${lookup(var.intra_outbound_acl_rules[count.index], "rule_action")}"
  from_port   = "${lookup(var.intra_outbound_acl_rules[count.index], "from_port")}"
  to_port     = "${lookup(var.intra_outbound_acl_rules[count.index], "to_port")}"
  protocol    = "${lookup(var.intra_outbound_acl_rules[count.index], "protocol")}"
  cidr_block  = "${lookup(var.intra_outbound_acl_rules[count.index], "cidr_block")}"
}

########################
# Database Network ACLs
########################
resource "aws_network_acl" "database" {
  count = "${var.create_vpc && var.database_dedicated_network_acl && length(var.database_subnets) > 0 ? 1 : 0}"

  vpc_id     = "${element(concat(aws_vpc.this.*.id, list("")), 0)}"
  subnet_ids = ["${aws_subnet.database.*.id}"]

  tags = "${merge(map("Name", format("%s-${var.database_subnet_suffix}", var.name)), var.tags, var.database_acl_tags)}"
}

resource "aws_network_acl_rule" "database_inbound" {
  count = "${var.create_vpc && var.database_dedicated_network_acl && length(var.database_subnets) > 0 ? length(var.database_inbound_acl_rules) : 0}"

  network_acl_id = "${aws_network_acl.database.id}"

  egress      = false
  rule_number = "${lookup(var.database_inbound_acl_rules[count.index], "rule_number")}"
  rule_action = "${lookup(var.database_inbound_acl_rules[count.index], "rule_action")}"
  from_port   = "${lookup(var.database_inbound_acl_rules[count.index], "from_port")}"
  to_port     = "${lookup(var.database_inbound_acl_rules[count.index], "to_port")}"
  protocol    = "${lookup(var.database_inbound_acl_rules[count.index], "protocol")}"
  cidr_block  = "${lookup(var.database_inbound_acl_rules[count.index], "cidr_block")}"
}

resource "aws_network_acl_rule" "database_outbound" {
  count = "${var.create_vpc && var.database_dedicated_network_acl && length(var.database_subnets) > 0 ? length(var.database_outbound_acl_rules) : 0}"

  network_acl_id = "${aws_network_acl.database.id}"

  egress      = true
  rule_number = "${lookup(var.database_outbound_acl_rules[count.index], "rule_number")}"
  rule_action = "${lookup(var.database_outbound_acl_rules[count.index], "rule_action")}"
  from_port   = "${lookup(var.database_outbound_acl_rules[count.index], "from_port")}"
  to_port     = "${lookup(var.database_outbound_acl_rules[count.index], "to_port")}"
  protocol    = "${lookup(var.database_outbound_acl_rules[count.index], "protocol")}"
  cidr_block  = "${lookup(var.database_outbound_acl_rules[count.index], "cidr_block")}"
}

########################
# Redshift Network ACLs
########################
resource "aws_network_acl" "redshift" {
  count = "${var.create_vpc && var.redshift_dedicated_network_acl && length(var.redshift_subnets) > 0 ? 1 : 0}"

  vpc_id     = "${element(concat(aws_vpc.this.*.id, list("")), 0)}"
  subnet_ids = ["${aws_subnet.redshift.*.id}"]

  tags = "${merge(map("Name", format("%s-${var.redshift_subnet_suffix}", var.name)), var.tags, var.redshift_acl_tags)}"
}

resource "aws_network_acl_rule" "redshift_inbound" {
  count = "${var.create_vpc && var.redshift_dedicated_network_acl && length(var.redshift_subnets) > 0 ? length(var.redshift_inbound_acl_rules) : 0}"

  network_acl_id = "${aws_network_acl.redshift.id}"

  egress      = false
  rule_number = "${lookup(var.redshift_inbound_acl_rules[count.index], "rule_number")}"
  rule_action = "${lookup(var.redshift_inbound_acl_rules[count.index], "rule_action")}"
  from_port   = "${lookup(var.redshift_inbound_acl_rules[count.index], "from_port")}"
  to_port     = "${lookup(var.redshift_inbound_acl_rules[count.index], "to_port")}"
  protocol    = "${lookup(var.redshift_inbound_acl_rules[count.index], "protocol")}"
  cidr_block  = "${lookup(var.redshift_inbound_acl_rules[count.index], "cidr_block")}"
}

resource "aws_network_acl_rule" "redshift_outbound" {
  count = "${var.create_vpc && var.redshift_dedicated_network_acl && length(var.redshift_subnets) > 0 ? length(var.redshift_outbound_acl_rules) : 0}"

  network_acl_id = "${aws_network_acl.redshift.id}"

  egress      = true
  rule_number = "${lookup(var.redshift_outbound_acl_rules[count.index], "rule_number")}"
  rule_action = "${lookup(var.redshift_outbound_acl_rules[count.index], "rule_action")}"
  from_port   = "${lookup(var.redshift_outbound_acl_rules[count.index], "from_port")}"
  to_port     = "${lookup(var.redshift_outbound_acl_rules[count.index], "to_port")}"
  protocol    = "${lookup(var.redshift_outbound_acl_rules[count.index], "protocol")}"
  cidr_block  = "${lookup(var.redshift_outbound_acl_rules[count.index], "cidr_block")}"
}

###########################
# Elasticache Network ACLs
###########################
resource "aws_network_acl" "elasticache" {
  count = "${var.create_vpc && var.elasticache_dedicated_network_acl && length(var.elasticache_subnets) > 0 ? 1 : 0}"

  vpc_id     = "${element(concat(aws_vpc.this.*.id, list("")), 0)}"
  subnet_ids = ["${aws_subnet.elasticache.*.id}"]

  tags = "${merge(map("Name", format("%s-${var.elasticache_subnet_suffix}", var.name)), var.tags, var.elasticache_acl_tags)}"
}

resource "aws_network_acl_rule" "elasticache_inbound" {
  count = "${var.create_vpc && var.elasticache_dedicated_network_acl && length(var.elasticache_subnets) > 0 ? length(var.elasticache_inbound_acl_rules) : 0}"

  network_acl_id = "${aws_network_acl.elasticache.id}"

  egress      = false
  rule_number = "${lookup(var.elasticache_inbound_acl_rules[count.index], "rule_number")}"
  rule_action = "${lookup(var.elasticache_inbound_acl_rules[count.index], "rule_action")}"
  from_port   = "${lookup(var.elasticache_inbound_acl_rules[count.index], "from_port")}"
  to_port     = "${lookup(var.elasticache_inbound_acl_rules[count.index], "to_port")}"
  protocol    = "${lookup(var.elasticache_inbound_acl_rules[count.index], "protocol")}"
  cidr_block  = "${lookup(var.elasticache_inbound_acl_rules[count.index], "cidr_block")}"
}

resource "aws_network_acl_rule" "elasticache_outbound" {
  count = "${var.create_vpc && var.elasticache_dedicated_network_acl && length(var.elasticache_subnets) > 0 ? length(var.elasticache_outbound_acl_rules) : 0}"

  network_acl_id = "${aws_network_acl.elasticache.id}"

  egress      = true
  rule_number = "${lookup(var.elasticache_outbound_acl_rules[count.index], "rule_number")}"
  rule_action = "${lookup(var.elasticache_outbound_acl_rules[count.index], "rule_action")}"
  from_port   = "${lookup(var.elasticache_outbound_acl_rules[count.index], "from_port")}"
  to_port     = "${lookup(var.elasticache_outbound_acl_rules[count.index], "to_port")}"
  protocol    = "${lookup(var.elasticache_outbound_acl_rules[count.index], "protocol")}"
  cidr_block  = "${lookup(var.elasticache_outbound_acl_rules[count.index], "cidr_block")}"
}

##############
# NAT Gateway
##############
# Workaround for interpolation not being able to "short-circuit" the evaluation of the conditional branch that doesn't end up being used
# Source: https://github.com/hashicorp/terraform/issues/11566#issuecomment-289417805
#
# The logical expression would be
#
#    nat_gateway_ips = var.reuse_nat_ips ? var.external_nat_ip_ids : aws_eip.nat.*.id
#
# but then when count of aws_eip.nat.*.id is zero, this would throw a resource not found error on aws_eip.nat.*.id.
locals {
  nat_gateway_ips = "${split(",", (var.reuse_nat_ips ? join(",", var.external_nat_ip_ids) : join(",", aws_eip.nat.*.id)))}"
}

resource "aws_eip" "nat" {
  count = "${var.create_vpc && (var.enable_nat_gateway && ! var.reuse_nat_ips) ? local.nat_gateway_count : 0}"

  vpc = true

  tags = "${merge(map("Name", format("%s-${var.nat_eip_suffix}-%02d", var.name, count.index + 1)), var.tags, var.nat_eip_tags)}"
}

resource "aws_nat_gateway" "this" {
  count = "${var.create_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 0}"

  allocation_id = "${element(local.nat_gateway_ips, (var.single_nat_gateway ? 0 : count.index))}"
  subnet_id     = "${element(aws_subnet.public.*.id, (var.single_nat_gateway ? 0 : count.index))}"

  tags = "${merge(map("Name", format("%s-${var.natgw_suffix}-%02d", var.name, count.index + 1)), var.tags, var.nat_gateway_tags)}"

  depends_on = ["aws_internet_gateway.this"]
}

resource "aws_route" "private_nat_gateway" {
  count = "${var.create_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 0}"

  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.this.*.id, count.index)}"

  timeouts {
    create = "5m"
  }
}

###
# Endpoint for S3
###

data "aws_vpc_endpoint_service" "s3" {
  count = "${var.create_vpc && var.enable_s3_endpoint ? 1 : 0}"

  service = "s3"
}

resource "aws_vpc_endpoint" "s3" {
  count = "${var.create_vpc && var.enable_s3_endpoint ? 1 : 0}"

  vpc_id       = "${local.vpc_id}"
  service_name = "${data.aws_vpc_endpoint_service.s3.service_name}"
}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  count = "${var.create_vpc && var.enable_s3_endpoint ? local.nat_gateway_count : 0}"

  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
  route_table_id  = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_vpc_endpoint_route_table_association" "private_extra_s3" {
  count = "${var.create_vpc && var.enable_s3_endpoint && length(var.private_extra_subnets) > 0 ? length(var.private_extra_subnets) : 0}"

  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
  route_table_id  = "${element(aws_route_table.private_extra.*.id, count.index)}"
}

resource "aws_vpc_endpoint_route_table_association" "intra_s3" {
  count = "${var.create_vpc && var.enable_s3_endpoint && length(var.intra_subnets) > 0 ? 1 : 0}"

  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
  route_table_id  = "${element(aws_route_table.intra.*.id, 0)}"
}

resource "aws_vpc_endpoint_route_table_association" "public_s3" {
  count = "${var.create_vpc && var.enable_s3_endpoint && length(var.public_subnets) > 0 ? 1 : 0}"

  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
  route_table_id  = "${aws_route_table.public.id}"
}

###
# Endpoint for DynamoDB
###

data "aws_vpc_endpoint_service" "dynamodb" {
  count = "${var.create_vpc && var.enable_dynamodb_endpoint ? 1 : 0}"

  service = "dynamodb"
}

resource "aws_vpc_endpoint" "dynamodb" {
  count = "${var.create_vpc && var.enable_dynamodb_endpoint ? 1 : 0}"

  vpc_id       = "${local.vpc_id}"
  service_name = "${data.aws_vpc_endpoint_service.dynamodb.service_name}"
}

resource "aws_vpc_endpoint_route_table_association" "private_dynamodb" {
  count = "${var.create_vpc && var.enable_dynamodb_endpoint ? local.nat_gateway_count : 0}"

  vpc_endpoint_id = "${aws_vpc_endpoint.dynamodb.id}"
  route_table_id  = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_vpc_endpoint_route_table_association" "private_extra_dynamodb" {
  count = "${var.create_vpc && var.enable_dynamodb_endpoint && length(var.private_extra_subnets) > 0 ? length(var.private_extra_subnets) : 0}"

  vpc_endpoint_id = "${aws_vpc_endpoint.dynamodb.id}"
  route_table_id  = "${element(aws_route_table.private_extra.*.id, count.index)}"
}

resource "aws_vpc_endpoint_route_table_association" "intra_dynamodb" {
  count = "${var.create_vpc && var.enable_dynamodb_endpoint && length(var.intra_subnets) > 0 ? 1 : 0}"

  vpc_endpoint_id = "${aws_vpc_endpoint.dynamodb.id}"
  route_table_id  = "${element(aws_route_table.intra.*.id, 0)}"
}

resource "aws_vpc_endpoint_route_table_association" "public_dynamodb" {
  count = "${var.create_vpc && var.enable_dynamodb_endpoint && length(var.public_subnets) > 0 ? 1 : 0}"

  vpc_endpoint_id = "${aws_vpc_endpoint.dynamodb.id}"
  route_table_id  = "${aws_route_table.public.id}"
}

###
# Endpoint for KMS
###

data "aws_vpc_endpoint_service" "kms" {
  count = "${var.create_vpc && var.enable_kms_endpoint ? 1 : 0}"

  service = "kms"
}

resource "aws_vpc_endpoint" "kms" {
  count = "${var.create_vpc && var.enable_kms_endpoint ? 1 : 0}"

  vpc_id       = "${local.vpc_id}"
  service_name = "${data.aws_vpc_endpoint_service.kms.service_name}"
}

resource "aws_vpc_endpoint_route_table_association" "private_kms" {
  count = "${var.create_vpc && var.enable_kms_endpoint ? local.nat_gateway_count : 0}"

  vpc_endpoint_id = "${aws_vpc_endpoint.kms.id}"
  route_table_id  = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_vpc_endpoint_route_table_association" "private_extra_kms" {
  count = "${var.create_vpc && var.enable_kms_endpoint && length(var.private_extra_subnets) > 0 ? length(var.private_extra_subnets) : 0}"

  vpc_endpoint_id = "${aws_vpc_endpoint.kms.id}"
  route_table_id  = "${element(aws_route_table.private_extra.*.id, count.index)}"
}

resource "aws_vpc_endpoint_route_table_association" "intra_kms" {
  count = "${var.create_vpc && var.enable_kms_endpoint && length(var.intra_subnets) > 0 ? 1 : 0}"

  vpc_endpoint_id = "${aws_vpc_endpoint.kms.id}"
  route_table_id  = "${element(aws_route_table.intra.*.id, 0)}"
}

resource "aws_vpc_endpoint_route_table_association" "public_kms" {
  count = "${var.create_vpc && var.enable_kms_endpoint && length(var.public_subnets) > 0 ? 1 : 0}"

  vpc_endpoint_id = "${aws_vpc_endpoint.kms.id}"
  route_table_id  = "${aws_route_table.public.id}"
}

###
# Endpoint for SSM
###

data "aws_vpc_endpoint_service" "ssm" {
  count = "${var.create_vpc && var.enable_ssm_endpoint ? 1 : 0}"

  service = "ssm"
}

resource "aws_vpc_endpoint" "ssm" {
  count = "${var.create_vpc && var.enable_ssm_endpoint ? 1 : 0}"

  vpc_id            = "${local.vpc_id}"
  service_name      = "${data.aws_vpc_endpoint_service.ssm.service_name}"
  vpc_endpoint_type = "Interface"

  security_group_ids  = ["${split(",", element(concat(var.ssm_endpoint_security_group_ids, list("")), 0) != "" ? join(",", var.ssm_endpoint_security_group_ids) : aws_security_group.endpoint.id)}"]
  subnet_ids          = ["${coalescelist(var.ssm_endpoint_subnet_ids, aws_subnet.private.*.id)}"]
  private_dns_enabled = "${var.ssm_endpoint_private_dns_enabled}"
}

###
# Endpoint for SSMMESSAGES
###

data "aws_vpc_endpoint_service" "ssmmessages" {
  count = "${var.create_vpc && var.enable_ssmmessages_endpoint ? 1 : 0}"

  service = "ssmmessages"
}

resource "aws_vpc_endpoint" "ssmmessages" {
  count = "${var.create_vpc && var.enable_ssmmessages_endpoint ? 1 : 0}"

  vpc_id            = "${local.vpc_id}"
  service_name      = "${data.aws_vpc_endpoint_service.ssmmessages.service_name}"
  vpc_endpoint_type = "Interface"

  security_group_ids  = ["${split(",", element(concat(var.ssmmessages_endpoint_security_group_ids, list("")), 0) != "" ? join(",", var.ssmmessages_endpoint_security_group_ids) : aws_security_group.endpoint.id)}"]
  subnet_ids          = ["${coalescelist(var.ssmmessages_endpoint_subnet_ids, aws_subnet.private.*.id)}"]
  private_dns_enabled = "${var.ssmmessages_endpoint_private_dns_enabled}"
}

###
# VPC Endpoint for EC2
###

data "aws_vpc_endpoint_service" "ec2" {
  count = "${var.create_vpc && var.enable_ec2_endpoint ? 1 : 0}"

  service = "ec2"
}

resource "aws_vpc_endpoint" "ec2" {
  count = "${var.create_vpc && var.enable_ec2_endpoint ? 1 : 0}"

  vpc_id            = "${local.vpc_id}"
  service_name      = "${data.aws_vpc_endpoint_service.ec2.service_name}"
  vpc_endpoint_type = "Interface"

  security_group_ids  = ["${split(",", element(concat(var.ec2_endpoint_security_group_ids, list("")), 0) != "" ? join(",", var.ec2_endpoint_security_group_ids) : aws_security_group.endpoint.id)}"]
  subnet_ids          = ["${coalescelist(var.ec2_endpoint_subnet_ids, aws_subnet.private.*.id)}"]
  private_dns_enabled = "${var.ec2_endpoint_private_dns_enabled}"
}

###
# Endpoint for EC2MESSAGES
###

data "aws_vpc_endpoint_service" "ec2messages" {
  count = "${var.create_vpc && var.enable_ec2messages_endpoint ? 1 : 0}"

  service = "ec2messages"
}

resource "aws_vpc_endpoint" "ec2messages" {
  count = "${var.create_vpc && var.enable_ec2messages_endpoint ? 1 : 0}"

  vpc_id            = "${local.vpc_id}"
  service_name      = "${data.aws_vpc_endpoint_service.ec2messages.service_name}"
  vpc_endpoint_type = "Interface"

  security_group_ids  = ["${split(",", element(concat(var.ec2messages_endpoint_security_group_ids, list("")), 0) != "" ? join(",", var.ec2messages_endpoint_security_group_ids) : aws_security_group.endpoint.id)}"]
  subnet_ids          = ["${coalescelist(var.ec2messages_endpoint_subnet_ids, aws_subnet.private.*.id)}"]
  private_dns_enabled = "${var.ec2messages_endpoint_private_dns_enabled}"
}

###
# Endpoint for ECR API
###

data "aws_vpc_endpoint_service" "ecr_api" {
  count = "${var.create_vpc && var.enable_ecr_api_endpoint ? 1 : 0}"

  service = "ecr.api"
}

resource "aws_vpc_endpoint" "ecr_api" {
  count = "${var.create_vpc && var.enable_ecr_api_endpoint ? 1 : 0}"

  vpc_id            = "${local.vpc_id}"
  service_name      = "${data.aws_vpc_endpoint_service.ecr_api.service_name}"
  vpc_endpoint_type = "Interface"

  security_group_ids  = ["${split(",", element(concat(var.ecr_api_endpoint_security_group_ids, list("")), 0) != "" ? join(",", var.ecr_api_endpoint_security_group_ids) : aws_security_group.endpoint.id)}"]
  subnet_ids          = ["${coalescelist(var.ecr_api_endpoint_subnet_ids, aws_subnet.private.*.id)}"]
  private_dns_enabled = "${var.ecr_api_endpoint_private_dns_enabled}"
}

###
# Endpoint for ECR DKR
###

data "aws_vpc_endpoint_service" "ecr_dkr" {
  count = "${var.create_vpc && var.enable_ecr_dkr_endpoint ? 1 : 0}"

  service = "ecr.dkr"
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  count = "${var.create_vpc && var.enable_ecr_dkr_endpoint ? 1 : 0}"

  vpc_id            = "${local.vpc_id}"
  service_name      = "${data.aws_vpc_endpoint_service.ecr_dkr.service_name}"
  vpc_endpoint_type = "Interface"

  security_group_ids  = ["${split(",", element(concat(var.ecr_dkr_endpoint_security_group_ids, list("")), 0) != "" ? join(",", var.ecr_dkr_endpoint_security_group_ids) : aws_security_group.endpoint.id)}"]
  subnet_ids          = ["${coalescelist(var.ecr_dkr_endpoint_subnet_ids, aws_subnet.private.*.id)}"]
  private_dns_enabled = "${var.ecr_dkr_endpoint_private_dns_enabled}"
}

###
# Endpoint for API Gateway
###

data "aws_vpc_endpoint_service" "apigw" {
  count = "${var.create_vpc && var.enable_apigw_endpoint ? 1 : 0}"

  service = "execute-api"
}

resource "aws_vpc_endpoint" "apigw" {
  count = "${var.create_vpc && var.enable_apigw_endpoint ? 1 : 0}"

  vpc_id            = "${local.vpc_id}"
  service_name      = "${data.aws_vpc_endpoint_service.apigw.service_name}"
  vpc_endpoint_type = "Interface"

  security_group_ids  = ["${split(",", element(concat(var.apigw_endpoint_security_group_ids, list("")), 0) != "" ? join(",", var.apigw_endpoint_security_group_ids) : aws_security_group.endpoint.id)}"]
  subnet_ids          = ["${coalescelist(var.apigw_endpoint_subnet_ids, aws_subnet.private.*.id)}"]
  private_dns_enabled = "${var.apigw_endpoint_private_dns_enabled}"
}

###
# Endpoint for Cloudwatch logs
###

data "aws_vpc_endpoint_service" "cloudwatch_logs" {
  count   = "${var.create_vpc && var.enable_cloudwatch_logs_endpoint ? 1 : 0}"
  service = "logs"
}

resource "aws_vpc_endpoint" "cloudwatch_logs" {
  count = "${var.create_vpc && var.enable_cloudwatch_logs_endpoint ? 1 : 0}"

  vpc_id            = "${local.vpc_id}"
  service_name      = "${data.aws_vpc_endpoint_service.cloudwatch_logs.service_name}"
  vpc_endpoint_type = "Interface"

  security_group_ids  = ["${split(",", element(concat(var.cloudwatch_logs_endpoint_security_group_ids, list("")), 0) != "" ? join(",", var.cloudwatch_logs_endpoint_security_group_ids) : aws_security_group.endpoint.id)}"]
  subnet_ids          = ["${coalescelist(var.cloudwatch_logs_endpoint_subnet_ids, aws_subnet.private.*.id)}"]
  private_dns_enabled = "${var.cloudwatch_logs_endpoint_private_dns_enabled}"
}

###
# Route table association
###

resource "aws_route_table_association" "private" {
  count = "${var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0}"

  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, (var.single_nat_gateway ? 0 : count.index))}"
}

resource "aws_route_table_association" "database" {
  count = "${var.create_vpc && length(var.database_subnets) > 0 ? length(var.database_subnets) : 0}"

  subnet_id      = "${element(aws_subnet.database.*.id, count.index)}"
  route_table_id = "${element(coalescelist(aws_route_table.database.*.id, aws_route_table.private.*.id), (var.single_nat_gateway || var.create_database_subnet_route_table ? 0 : count.index))}"
}

resource "aws_route_table_association" "redshift" {
  count = "${var.create_vpc && length(var.redshift_subnets) > 0 && ! var.enable_public_redshift ? length(var.redshift_subnets) : 0}"

  subnet_id      = "${element(aws_subnet.redshift.*.id, count.index)}"
  route_table_id = "${element(coalescelist(aws_route_table.redshift.*.id, aws_route_table.private.*.id), (var.single_nat_gateway || var.create_redshift_subnet_route_table ? 0 : count.index))}"
}

resource "aws_route_table_association" "redshift_public" {
  count = "${var.create_vpc && length(var.redshift_subnets) > 0 && var.enable_public_redshift ? length(var.redshift_subnets) : 0}"

  subnet_id      = "${element(aws_subnet.redshift.*.id, count.index)}"
  route_table_id = "${element(coalescelist(aws_route_table.redshift.*.id, aws_route_table.public.*.id), (var.single_nat_gateway || var.create_redshift_subnet_route_table ? 0 : count.index))}"
}

resource "aws_route_table_association" "elasticache" {
  count = "${var.create_vpc && length(var.elasticache_subnets) > 0 ? length(var.elasticache_subnets) : 0}"

  subnet_id      = "${element(aws_subnet.elasticache.*.id, count.index)}"
  route_table_id = "${element(coalescelist(aws_route_table.elasticache.*.id, aws_route_table.private.*.id), (var.single_nat_gateway || var.create_elasticache_subnet_route_table ? 0 : count.index))}"
}

resource "aws_route_table_association" "intra" {
  count = "${var.create_vpc && length(var.intra_subnets) > 0 ? length(var.intra_subnets) : 0}"

  subnet_id      = "${element(aws_subnet.intra.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.intra.*.id, 0)}"
}

resource "aws_route_table_association" "public" {
  count = "${var.create_vpc && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0}"

  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

##############
# VPN Gateway
##############
resource "aws_vpn_gateway" "this" {
  count = "${var.create_vpc && var.enable_vpn_gateway ? 1 : 0}"

  vpc_id          = "${local.vpc_id}"
  amazon_side_asn = "${var.amazon_side_asn}"

  tags = "${merge(map("Name", format("%s", var.name)), var.tags, var.vpn_gateway_tags)}"
}

resource "aws_vpn_gateway_attachment" "this" {
  count = "${var.vpn_gateway_id != "" ? 1 : 0}"

  vpc_id         = "${local.vpc_id}"
  vpn_gateway_id = "${var.vpn_gateway_id}"
}

resource "aws_vpn_gateway_route_propagation" "public" {
  count = "${var.create_vpc && var.propagate_public_route_tables_vgw && (var.enable_vpn_gateway || var.vpn_gateway_id != "") ? 1 : 0}"

  route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
  vpn_gateway_id = "${element(concat(aws_vpn_gateway.this.*.id, aws_vpn_gateway_attachment.this.*.vpn_gateway_id), count.index)}"
}

resource "aws_vpn_gateway_route_propagation" "private" {
  count = "${var.create_vpc && var.propagate_private_route_tables_vgw && (var.enable_vpn_gateway || var.vpn_gateway_id != "") ? length(var.private_subnets) : 0}"

  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  vpn_gateway_id = "${element(concat(aws_vpn_gateway.this.*.id, aws_vpn_gateway_attachment.this.*.vpn_gateway_id), count.index)}"
}

###########
# Defaults
###########
resource "aws_default_vpc" "this" {
  count = "${var.manage_default_vpc ? 1 : 0}"

  enable_dns_support   = "${var.default_vpc_enable_dns_support}"
  enable_dns_hostnames = "${var.default_vpc_enable_dns_hostnames}"
  enable_classiclink   = "${var.default_vpc_enable_classiclink}"

  tags = "${merge(map("Name", format("%s", var.default_vpc_name)), var.tags, var.default_vpc_tags)}"
}
