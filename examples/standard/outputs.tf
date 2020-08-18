#####
# Counts
# Counts to mitigate Terraform 0.11.X inability to count modules attributes
#####

output "total_subnets_count" {
  value = "${module.standard.total_subnets_count}"
}

output "public_subnets_count" {
  value = "${module.standard.public_subnets_count}"
}

output "private_subnets_count" {
  value = "${module.standard.private_subnets_count}"
}

output "private_extra_subnets_count" {
  value = "${module.standard.private_extra_subnets_count}"
}

output "intra_subnets_count" {
  value = "${module.standard.intra_subnets_count}"
}

output "database_subnets_count" {
  value = "${module.standard.database_subnets_count}"
}

output "redshift_subnets_count" {
  value = "${module.standard.redshift_subnets_count}"
}

output "elasticache_subnets_count" {
  value = "${module.standard.elasticache_subnets_count}"
}

output "public_route_table_count" {
  value = "${module.standard.public_route_table_count}"
}

output "private_route_table_count" {
  value = "${module.standard.private_route_table_count}"
}

output "private_extra_route_table_count" {
  value = "${module.standard.private_extra_route_table_count}"
}

output "intra_route_table_count" {
  value = "${module.standard.intra_route_table_count}"
}

output "database_route_table_count" {
  value = "${module.standard.database_route_table_count}"
}

output "redshift_route_table_count" {
  value = "${module.standard.redshift_route_table_count}"
}

output "elasticache_route_table_count" {
  value = "${module.standard.elasticache_route_table_count}"
}

output "nat_gateway_count" {
  value = "${module.standard.nat_gateway_count}"
}

#####
# VPC
#####

output "vpc_id" {
  value = "${module.standard.vpc_id}"
}

output "vpc_cidr_block" {
  value = "${module.standard.vpc_cidr_block}"
}

output "default_security_group_id" {
  value = "${module.standard.default_security_group_id}"
}

output "default_network_acl_id" {
  value = "${module.standard.default_network_acl_id}"
}

output "default_route_table_id" {
  value = "${module.standard.default_route_table_id}"
}

output "vpc_instance_tenancy" {
  value = "${module.standard.vpc_instance_tenancy}"
}

output "vpc_enable_dns_support" {
  value = "${module.standard.vpc_enable_dns_support}"
}

output "vpc_enable_dns_hostnames" {
  value = "${module.standard.vpc_enable_dns_hostnames}"
}

output "vpc_main_route_table_id" {
  value = "${module.standard.vpc_main_route_table_id}"
}

output "vpc_secondary_cidr_blocks" {
  value = "${module.standard.vpc_secondary_cidr_blocks}"
}

output "private_subnets" {
  value = "${module.standard.private_subnets}"
}

output "private_subnets_cidr_blocks" {
  value = "${module.standard.private_subnets_cidr_blocks}"
}

output "private_extra_subnets" {
  value = "${module.standard.private_extra_subnets}"
}

output "private_extra_subnets_cidr_blocks" {
  value = "${module.standard.private_extra_subnets_cidr_blocks}"
}

output "public_subnets" {
  value = "${module.standard.public_subnets}"
}

output "public_subnets_cidr_blocks" {
  value = "${module.standard.public_subnets_cidr_blocks}"
}

output "database_subnets" {
  value = "${module.standard.database_subnets}"
}

output "database_subnets_cidr_blocks" {
  value = "${module.standard.database_subnets_cidr_blocks}"
}

output "database_subnet_group" {
  value = "${module.standard.database_subnet_group}"
}

output "redshift_subnets" {
  value = "${module.standard.redshift_subnets}"
}

output "redshift_subnets_cidr_blocks" {
  value = "${module.standard.redshift_subnets_cidr_blocks}"
}

output "redshift_subnet_group" {
  value = "${module.standard.redshift_subnet_group}"
}

output "elasticache_subnets" {
  value = "${module.standard.elasticache_subnets}"
}

output "elasticache_subnets_cidr_blocks" {
  value = "${module.standard.elasticache_subnets_cidr_blocks}"
}

output "intra_subnets" {
  value = "${module.standard.intra_subnets}"
}

output "intra_subnets_cidr_blocks" {
  value = "${module.standard.intra_subnets_cidr_blocks}"
}

output "elasticache_subnet_group" {
  value = "${module.standard.elasticache_subnet_group}"
}

output "elasticache_subnet_group_name" {
  value = "${module.standard.elasticache_subnet_group_name}"
}

output "public_route_table_ids" {
  value = "${module.standard.public_route_table_ids}"
}

output "private_route_table_ids" {
  value = "${module.standard.private_route_table_ids}"
}

output "private_extra_route_table_ids" {
  value = "${module.standard.private_extra_route_table_ids}"
}

output "database_route_table_ids" {
  value = "${module.standard.database_route_table_ids}"
}

output "redshift_route_table_ids" {
  value = "${module.standard.redshift_route_table_ids}"
}

output "elasticache_route_table_ids" {
  value = "${module.standard.elasticache_route_table_ids}"
}

output "intra_route_table_ids" {
  value = "${module.standard.intra_route_table_ids}"
}

output "nat_ids" {
  value = "${module.standard.nat_ids}"
}

output "nat_public_ips" {
  value = "${module.standard.nat_public_ips}"
}

output "natgw_ids" {
  value = "${module.standard.natgw_ids}"
}

output "igw_id" {
  value = "${module.standard.igw_id}"
}

output "vgw_id" {
  value = "${module.standard.vgw_id}"
}

output "default_vpc_id" {
  value = "${module.standard.default_vpc_id}"
}

output "default_vpc_cidr_block" {
  value = "${module.standard.default_vpc_cidr_block}"
}

output "default_vpc_default_security_group_id" {
  value = "${module.standard.default_vpc_default_security_group_id}"
}

output "default_vpc_default_network_acl_id" {
  value = "${module.standard.default_vpc_default_network_acl_id}"
}

output "default_vpc_default_route_table_id" {
  value = "${module.standard.default_vpc_default_route_table_id}"
}

output "default_vpc_instance_tenancy" {
  value = "${module.standard.default_vpc_instance_tenancy}"
}

output "default_vpc_enable_dns_support" {
  value = "${module.standard.default_vpc_enable_dns_support}"
}

output "default_vpc_enable_dns_hostnames" {
  value = "${module.standard.default_vpc_enable_dns_hostnames}"
}

output "default_vpc_main_route_table_id" {
  value = "${module.standard.default_vpc_main_route_table_id}"
}

output "public_network_acl_id" {
  value = "${module.standard.public_network_acl_id}"
}

output "private_network_acl_id" {
  value = "${module.standard.private_network_acl_id}"
}

output "private_extra_network_acl_id" {
  value = "${module.standard.private_extra_network_acl_id}"
}

output "intra_network_acl_id" {
  value = "${module.standard.intra_network_acl_id}"
}

output "database_network_acl_id" {
  value = "${module.standard.database_network_acl_id}"
}

output "redshift_network_acl_id" {
  value = "${module.standard.redshift_network_acl_id}"
}

output "elasticache_network_acl_id" {
  value = "${module.standard.elasticache_network_acl_id}"
}

####
# VPC Endpoints
####

output "vpc_endpoint_s3_id" {
  value = "${module.standard.vpc_endpoint_s3_id}"
}

output "vpc_endpoint_s3_pl_id" {
  value = "${module.standard.vpc_endpoint_s3_pl_id}"
}

output "vpc_endpoint_dynamodb_id" {
  value = "${module.standard.vpc_endpoint_dynamodb_id}"
}

output "vpc_endpoint_dynamodb_pl_id" {
  value = "${module.standard.vpc_endpoint_dynamodb_pl_id}"
}

output "vpc_endpoint_kms_id" {
  value = "${module.standard.vpc_endpoint_kms_id}"
}

output "vpc_endpoint_kms_network_interface_ids" {
  value = "${module.standard.vpc_endpoint_kms_network_interface_ids}"
}

output "vpc_endpoint_kms_dns_entry" {
  value = "${module.standard.vpc_endpoint_kms_dns_entry}"
}

output "vpc_endpoint_sts_id" {
  value = "${module.standard.vpc_endpoint_sts_id}"
}

output "vpc_endpoint_sts_network_interface_ids" {
  value = "${module.standard.vpc_endpoint_sts_network_interface_ids}"
}

output "vpc_endpoint_sts_dns_entry" {
  value = "${module.standard.vpc_endpoint_sts_dns_entry}"
}

output "vpc_endpoint_ssm_id" {
  value = "${module.standard.vpc_endpoint_ssm_id}"
}

output "vpc_endpoint_ssm_network_interface_ids" {
  value = "${module.standard.vpc_endpoint_ssm_network_interface_ids}"
}

output "vpc_endpoint_ssm_dns_entry" {
  value = "${module.standard.vpc_endpoint_ssm_dns_entry}"
}

output "vpc_endpoint_ssmmessages_id" {
  value = "${module.standard.vpc_endpoint_ssmmessages_id}"
}

output "vpc_endpoint_ssmmessages_network_interface_ids" {
  value = "${module.standard.vpc_endpoint_ssmmessages_network_interface_ids}"
}

output "vpc_endpoint_ssmmessages_dns_entry" {
  value = "${module.standard.vpc_endpoint_ssmmessages_dns_entry}"
}

output "vpc_endpoint_ec2_id" {
  value = "${module.standard.vpc_endpoint_ec2_id}"
}

output "vpc_endpoint_ec2_network_interface_ids" {
  value = "${module.standard.vpc_endpoint_ec2_network_interface_ids}"
}

output "vpc_endpoint_ec2_dns_entry" {
  value = "${module.standard.vpc_endpoint_ec2_dns_entry}"
}

output "vpc_endpoint_ec2messages_id" {
  value = "${module.standard.vpc_endpoint_ec2messages_id}"
}

output "vpc_endpoint_ec2messages_network_interface_ids" {
  value = "${module.standard.vpc_endpoint_ec2messages_network_interface_ids}"
}

output "vpc_endpoint_ec2messages_dns_entry" {
  value = "${module.standard.vpc_endpoint_ec2messages_dns_entry}"
}

output "vpc_endpoint_cloudwatch_logs_id" {
  value = "${module.standard.vpc_endpoint_cloudwatch_logs_id}"
}

output "vpc_endpoint_cloudwatch_logs_network_interface_ids" {
  value = "${module.standard.vpc_endpoint_cloudwatch_logs_network_interface_ids}"
}

output "vpc_endpoint_cloudwatch_logs_dns_entry" {
  value = "${module.standard.vpc_endpoint_cloudwatch_logs_dns_entry}"
}

output "vpc_endpoint_monitoring_id" {
  value = "${module.standard.vpc_endpoint_monitoring_id}"
}

output "vpc_endpoint_monitoring_network_interface_ids" {
  value = "${module.standard.vpc_endpoint_monitoring_network_interface_ids}"
}

output "vpc_endpoint_monitoring_dns_entry" {
  value = "${module.standard.vpc_endpoint_monitoring_dns_entry}"
}

#####
# Security Groups
#####

output "vpc_endpoint_security_group_id" {
  value = "${module.standard.vpc_endpoint_security_group_id}"
}
