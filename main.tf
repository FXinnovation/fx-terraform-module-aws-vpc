#####
# VPC
#####

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.60.0"

  azs  = "${var.azs}"
  name = "${var.name}"
  cidr = "${var.cidr}"

  enable_nat_gateway     = "${var.enable_nat_gateway}"
  one_nat_gateway_per_az = "${var.one_nat_gateway_per_az}"

  tags = "${merge(map("Terraform", "true"), var.tags)}"
}

locals {
  max_subnet_length = "${max(length(var.private_subnets), length(var.elasticache_subnets), length(var.database_subnets), length(var.redshift_subnets))}"
  nat_gateway_count = "${var.single_nat_gateway ? 1 : (var.one_nat_gateway_per_az ? length(var.azs) : local.max_subnet_length)}"
}

####
# Private subnet
####

resource "aws_subnet" "private_extra" {
  count = "${var.create_vpc && length(var.private_extra_subnets) > 0 ? length(var.private_extra_subnets) : 0}"

  vpc_id            = "${module.vpc.vpc_id}"
  cidr_block        = "${var.private_extra_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"

  tags = "${merge(map("Name", format("%s-${var.private_extra_subnet_suffix}-%s", var.name, element(var.azs, count.index))), var.tags, var.private_extra_subnet_tags)}"
}

####
# Private extra routes
####
resource "aws_route_table" "private_extra" {
  count = "${var.create_vpc && local.max_subnet_length > 0 ? local.nat_gateway_count : 0}"

  vpc_id = "${module.vpc.vpc_id}"

  tags = "${merge(map("Name", (var.single_nat_gateway ? "${var.name}-${var.private_extra_subnet_suffix}" : format("%s-${var.private_extra_subnet_suffix}-%s", var.name, element(var.azs, count.index)))), var.tags, var.private_extra_route_table_tags)}"

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
  count = "${var.create_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 0}"

  route_table_id         = "${element(aws_route_table.private_extra.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(module.vpc.natgw_ids, count.index)}"

  timeouts {
    create = "5m"
  }
}

####
# Private Network ACLs
####
resource "aws_network_acl" "private_extra" {
  count = "${var.create_vpc && var.private_extra_dedicated_network_acl && length(var.private_extra_subnets) > 0 ? 1 : 0}"

  vpc_id     = "${module.vpc.vpc_id}"
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
