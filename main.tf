#####
# VPC
#####

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.60.0"

  create_vpc                       = "${var.create_vpc}"
  name                             = "${var.name}"
  cidr                             = "${var.cidr}"
  assign_generated_ipv6_cidr_block = "${var.assign_generated_ipv6_cidr_block}"
  secondary_cidr_blocks            = "${var.secondary_cidr_blocks}"
  instance_tenancy                 = "${var.instance_tenancy}"

  public_subnet_suffix      = "${var.public_subnet_suffix}"
  private_subnet_suffix     = "${var.private_subnet_suffix}"
  intra_subnet_suffix       = "${var.intra_subnet_suffix}"
  database_subnet_suffix    = "${var.database_subnet_suffix}"
  redshift_subnet_suffix    = "${var.redshift_subnet_suffix}"
  elasticache_subnet_suffix = "${var.elasticache_subnet_suffix}"

  public_subnets      = "${var.public_subnets}"
  private_subnets     = "${var.private_subnets}"
  database_subnets    = "${var.database_subnets}"
  redshift_subnets    = "${var.redshift_subnets}"
  elasticache_subnets = "${var.elasticache_subnets}"
  intra_subnets       = "${var.intra_subnets}"

  create_database_subnet_route_table = "${var.create_database_subnet_route_table}"
  create_redshift_subnet_route_table = "${var.create_redshift_subnet_route_table}"
  enable_public_redshift             = "${var.enable_public_redshift}"

  create_elasticache_subnet_route_table  = "${var.create_elasticache_subnet_route_table}"
  create_database_subnet_group           = "${var.create_database_subnet_group}"
  create_elasticache_subnet_group        = "${var.create_elasticache_subnet_group}"
  create_redshift_subnet_group           = "${var.create_redshift_subnet_group}"
  create_database_internet_gateway_route = "${var.create_database_internet_gateway_route}"
  create_database_nat_gateway_route      = "${var.create_database_nat_gateway_route}"

  azs = "${var.azs}"

  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  enable_nat_gateway     = "${var.enable_nat_gateway}"
  single_nat_gateway     = "${var.single_nat_gateway}"
  one_nat_gateway_per_az = "${var.one_nat_gateway_per_az}"
  reuse_nat_ips          = "${var.reuse_nat_ips}"
  external_nat_ip_ids    = "${var.external_nat_ip_ids}"

  enable_dynamodb_endpoint = "${var.enable_dynamodb_endpoint}"

  enable_s3_endpoint = "${var.enable_s3_endpoint}"

  enable_ssm_endpoint = "${var.enable_ssm_endpoint}"

  ssm_endpoint_security_group_ids  = "${var.ssm_endpoint_security_group_ids}"
  ssm_endpoint_subnet_ids          = "${var.ssm_endpoint_subnet_ids}"
  ssm_endpoint_private_dns_enabled = "${var.ssm_endpoint_private_dns_enabled}"

  enable_ssmmessages_endpoint = "${var.enable_ssmmessages_endpoint}"
  enable_apigw_endpoint       = "${var.enable_apigw_endpoint}"

  apigw_endpoint_security_group_ids  = "${var.apigw_endpoint_security_group_ids}"
  apigw_endpoint_private_dns_enabled = "${var.apigw_endpoint_private_dns_enabled}"
  apigw_endpoint_subnet_ids          = "${var.apigw_endpoint_subnet_ids}"

  ssmmessages_endpoint_security_group_ids  = "${var.ssmmessages_endpoint_security_group_ids}"
  ssmmessages_endpoint_subnet_ids          = "${var.ssmmessages_endpoint_subnet_ids}"
  ssmmessages_endpoint_private_dns_enabled = "${var.ssmmessages_endpoint_private_dns_enabled}"

  enable_ec2_endpoint = "${var.enable_ec2_endpoint}"

  ec2_endpoint_security_group_ids          = "${var.ec2_endpoint_security_group_ids}"
  ec2_endpoint_private_dns_enabled         = "${var.ec2_endpoint_private_dns_enabled}"
  ec2_endpoint_subnet_ids                  = "${var.ec2_endpoint_subnet_ids}"
  enable_ec2messages_endpoint              = "${var.enable_ec2messages_endpoint}"
  ec2messages_endpoint_security_group_ids  = "${var.ec2messages_endpoint_security_group_ids}"
  ec2messages_endpoint_private_dns_enabled = "${var.ec2messages_endpoint_private_dns_enabled}"

  ec2messages_endpoint_subnet_ids = "${var.ec2messages_endpoint_subnet_ids}"
  enable_ecr_api_endpoint         = "${var.enable_ecr_api_endpoint}"

  ecr_api_endpoint_subnet_ids          = "${var.ecr_api_endpoint_subnet_ids}"
  ecr_api_endpoint_private_dns_enabled = "${var.ecr_api_endpoint_private_dns_enabled}"
  ecr_api_endpoint_security_group_ids  = "${var.ecr_api_endpoint_security_group_ids}"
  enable_ecr_dkr_endpoint              = "${var.enable_ecr_dkr_endpoint}"
  ecr_dkr_endpoint_subnet_ids          = "${var.ecr_dkr_endpoint_subnet_ids}"
  ecr_dkr_endpoint_private_dns_enabled = "${var.ecr_dkr_endpoint_private_dns_enabled}"
  ecr_dkr_endpoint_security_group_ids  = "${var.ecr_dkr_endpoint_security_group_ids}"

  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"

  enable_vpn_gateway = "${var.enable_vpn_gateway}"

  vpn_gateway_id                     = "${var.vpn_gateway_id}"
  amazon_side_asn                    = "${var.amazon_side_asn}"
  propagate_private_route_tables_vgw = "${var.propagate_private_route_tables_vgw}"
  propagate_public_route_tables_vgw  = "${var.propagate_public_route_tables_vgw}"
  tags                               = "${merge(map("Terraform", "true"), var.tags)}"
  vpc_tags                           = "${var.vpc_tags}"
  igw_tags                           = "${var.igw_tags}"
  public_subnet_tags                 = "${var.public_subnet_tags}"
  private_subnet_tags                = "${var.private_subnet_tags}"
  public_route_table_tags            = "${var.public_route_table_tags}"
  private_route_table_tags           = "${var.private_route_table_tags}"
  database_route_table_tags          = "${var.database_route_table_tags}"
  redshift_route_table_tags          = "${var.redshift_route_table_tags}"
  elasticache_route_table_tags       = "${var.elasticache_route_table_tags}"
  intra_route_table_tags             = "${var.intra_route_table_tags}"
  database_subnet_tags               = "${var.database_subnet_tags}"
  database_subnet_group_tags         = "${var.database_subnet_group_tags}"
  redshift_subnet_tags               = "${var.redshift_subnet_tags}"
  redshift_subnet_group_tags         = "${var.redshift_subnet_group_tags}"
  elasticache_subnet_tags            = "${var.elasticache_subnet_tags}"
  intra_subnet_tags                  = "${var.intra_subnet_tags}"
  public_acl_tags                    = "${var.public_acl_tags}"
  private_acl_tags                   = "${var.private_acl_tags}"
  intra_acl_tags                     = "${var.intra_acl_tags}"
  database_acl_tags                  = "${var.database_acl_tags}"
  redshift_acl_tags                  = "${var.redshift_acl_tags}"
  elasticache_acl_tags               = "${var.elasticache_acl_tags}"

  dhcp_options_tags = "${var.dhcp_options_tags}"

  nat_gateway_tags = "${var.nat_gateway_tags}"
  nat_eip_tags     = "${var.nat_eip_tags}"

  vpn_gateway_tags = "${var.vpn_gateway_tags}"

  enable_dhcp_options = "${var.enable_dhcp_options}"

  dhcp_options_domain_name          = "${var.dhcp_options_domain_name}"
  dhcp_options_domain_name_servers  = "${var.dhcp_options_domain_name_servers}"
  dhcp_options_ntp_servers          = "${var.dhcp_options_ntp_servers}"
  dhcp_options_netbios_name_servers = "${var.dhcp_options_netbios_name_servers}"
  dhcp_options_netbios_node_type    = "${var.dhcp_options_netbios_node_type}"

  manage_default_vpc = "${var.manage_default_vpc}"

  default_vpc_name                 = "${var.default_vpc_name}"
  default_vpc_enable_dns_support   = "${var.default_vpc_enable_dns_support}"
  default_vpc_enable_dns_hostnames = "${var.default_vpc_enable_dns_hostnames}"
  default_vpc_enable_classiclink   = "${var.default_vpc_enable_classiclink}"
  default_vpc_tags                 = "${var.default_vpc_tags}"

  manage_default_network_acl        = "${var.manage_default_network_acl}"
  default_network_acl_name          = "${var.default_network_acl_name}"
  default_network_acl_tags          = "${var.default_network_acl_tags}"
  public_dedicated_network_acl      = "${var.public_dedicated_network_acl}"
  private_dedicated_network_acl     = "${var.private_dedicated_network_acl}"
  intra_dedicated_network_acl       = "${var.intra_dedicated_network_acl}"
  database_dedicated_network_acl    = "${var.database_dedicated_network_acl}"
  redshift_dedicated_network_acl    = "${var.redshift_dedicated_network_acl}"
  elasticache_dedicated_network_acl = "${var.elasticache_dedicated_network_acl}"
  default_network_acl_ingress       = "${var.default_network_acl_ingress}"
  default_network_acl_egress        = "${var.default_network_acl_egress}"
  public_inbound_acl_rules          = "${var.public_inbound_acl_rules}"
  public_outbound_acl_rules         = "${var.public_outbound_acl_rules}"
  private_inbound_acl_rules         = "${var.private_inbound_acl_rules}"
  private_outbound_acl_rules        = "${var.private_outbound_acl_rules}"
  intra_inbound_acl_rules           = "${var.intra_inbound_acl_rules}"
  intra_outbound_acl_rules          = "${var.intra_outbound_acl_rules}"
  database_inbound_acl_rules        = "${var.database_inbound_acl_rules}"
  database_outbound_acl_rules       = "${var.database_outbound_acl_rules}"
  redshift_inbound_acl_rules        = "${var.redshift_inbound_acl_rules}"
  redshift_outbound_acl_rules       = "${var.redshift_outbound_acl_rules}"
  elasticache_inbound_acl_rules     = "${var.elasticache_inbound_acl_rules}"
  elasticache_outbound_acl_rules    = "${var.elasticache_outbound_acl_rules}"
}

locals {
  max_subnet_length = "${max(length(var.private_subnets), length(var.private_extra_subnets), length(var.elasticache_subnets), length(var.database_subnets), length(var.redshift_subnets))}"
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
