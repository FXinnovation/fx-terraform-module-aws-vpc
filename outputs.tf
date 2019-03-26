#####
# Counts
# // Counts for Terraform 0.11.X inability to count modules attributes
#####

output "total_subnets_count" {
  description = "Count of all the subnets"
  value       = "${local.max_subnet_length}"
}

output "public_subnets_count" {
  description = "Count of public subnets"
  value       = "${length(aws_subnet.public.*.id)}"
}

output "private_subnets_count" {
  description = "Count of private subnets"
  value       = "${length(aws_subnet.private.*.id)}"
}

output "private_extra_subnets_count" {
  description = "Count of private extra subnets"
  value       = "${length(aws_subnet.private_extra.*.id)}"
}

output "intra_subnets_count" {
  description = "Count of intra subnets"
  value       = "${length(aws_subnet.intra.*.id)}"
}

output "database_subnets_count" {
  description = "Count of database subnets"
  value       = "${length(aws_subnet.database.*.id)}"
}

output "redshift_subnets_count" {
  description = "Count of redshift subnets"
  value       = "${length(aws_subnet.redshift.*.id)}"
}

output "elasticache_subnets_count" {
  description = "Count of elasticache subnets"
  value       = "${length(aws_subnet.elasticache.*.id)}"
}

output "public_route_table_count" {
  description = "Count of public route tables"
  value       = "${length(aws_route_table.public.*.id)}"
}

output "private_route_table_count" {
  description = "Count of private route tables"
  value       = "${length(aws_route_table.private.*.id)}"
}

output "private_extra_route_table_count" {
  description = "Count of private extra route tables"
  value       = "${length(aws_route_table.private_extra.*.id)}"
}

output "intra_route_table_count" {
  description = "Count of public route tables"
  value       = "${length(aws_route_table.intra.*.id)}"
}

output "database_route_table_count" {
  description = "Count of database route tables"
  value       = "${length(coalescelist(aws_route_table.database.*.id, aws_route_table.private.*.id))}"
}

output "redshift_route_table_count" {
  description = "Count of redshift route tables"
  value       = "${length(coalescelist(aws_route_table.redshift.*.id, aws_route_table.private.*.id))}"
}

output "elasticache_route_table_count" {
  description = "Count of elasticache route tables"
  value       = "${length(coalescelist(aws_route_table.elasticache.*.id, aws_route_table.private.*.id))}"
}

output "nat_gateway_count" {
  description = "Count of NAT Gateways"
  value       = "${length(aws_nat_gateway.this.*.id)}"
}

#####
# VPC
#  https://github.com/terraform-aws-modules/terraform-aws-vpc/
#####

output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${element(concat(aws_vpc.this.*.id, list("")), 0)}"
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = "${element(concat(aws_vpc.this.*.cidr_block, list("")), 0)}"
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = "${element(concat(aws_vpc.this.*.default_security_group_id, list("")), 0)}"
}

output "default_network_acl_id" {
  description = "The ID of the default network ACL"
  value       = "${element(concat(aws_vpc.this.*.default_network_acl_id, list("")), 0)}"
}

output "default_route_table_id" {
  description = "The ID of the default route table"
  value       = "${element(concat(aws_vpc.this.*.default_route_table_id, list("")), 0)}"
}

output "vpc_instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  value       = "${element(concat(aws_vpc.this.*.instance_tenancy, list("")), 0)}"
}

output "vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = "${element(concat(aws_vpc.this.*.enable_dns_support, list("")), 0)}"
}

output "vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = "${element(concat(aws_vpc.this.*.enable_dns_hostnames, list("")), 0)}"
}

output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = "${element(concat(aws_vpc.this.*.main_route_table_id, list("")), 0)}"
}

output "vpc_secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks of the VPC"
  value       = ["${aws_vpc_ipv4_cidr_block_association.this.*.cidr_block}"]
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = ["${aws_subnet.private.*.id}"]
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = ["${aws_subnet.private.*.cidr_block}"]
}

output "private_extra_subnets" {
  description = "List of IDs of private extra subnets"
  value       = ["${aws_subnet.private_extra.*.id}"]
}

output "private_extra_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private extra subnets"
  value       = ["${aws_subnet.private_extra.*.cidr_block}"]
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = ["${aws_subnet.public.*.id}"]
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = ["${aws_subnet.public.*.cidr_block}"]
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = ["${aws_subnet.database.*.id}"]
}

output "database_subnets_cidr_blocks" {
  description = "List of cidr_blocks of database subnets"
  value       = ["${aws_subnet.database.*.cidr_block}"]
}

output "database_subnet_group" {
  description = "ID of database subnet group"
  value       = "${element(concat(aws_db_subnet_group.database.*.id, list("")), 0)}"
}

output "redshift_subnets" {
  description = "List of IDs of redshift subnets"
  value       = ["${aws_subnet.redshift.*.id}"]
}

output "redshift_subnets_cidr_blocks" {
  description = "List of cidr_blocks of redshift subnets"
  value       = ["${aws_subnet.redshift.*.cidr_block}"]
}

output "redshift_subnet_group" {
  description = "ID of redshift subnet group"
  value       = "${element(concat(aws_redshift_subnet_group.redshift.*.id, list("")), 0)}"
}

output "elasticache_subnets" {
  description = "List of IDs of elasticache subnets"
  value       = ["${aws_subnet.elasticache.*.id}"]
}

output "elasticache_subnets_cidr_blocks" {
  description = "List of cidr_blocks of elasticache subnets"
  value       = ["${aws_subnet.elasticache.*.cidr_block}"]
}

output "intra_subnets" {
  description = "List of IDs of intra subnets"
  value       = ["${aws_subnet.intra.*.id}"]
}

output "intra_subnets_cidr_blocks" {
  description = "List of cidr_blocks of intra subnets"
  value       = ["${aws_subnet.intra.*.cidr_block}"]
}

output "elasticache_subnet_group" {
  description = "ID of elasticache subnet group"
  value       = "${element(concat(aws_elasticache_subnet_group.elasticache.*.id, list("")), 0)}"
}

output "elasticache_subnet_group_name" {
  description = "Name of elasticache subnet group"
  value       = "${element(concat(aws_elasticache_subnet_group.elasticache.*.name, list("")), 0)}"
}

output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = ["${aws_route_table.public.*.id}"]
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = ["${aws_route_table.private.*.id}"]
}

output "private_extra_route_table_ids" {
  description = "List of IDs of private extra route tables"
  value       = ["${aws_route_table.private_extra.*.id}"]
}

output "database_route_table_ids" {
  description = "List of IDs of database route tables"
  value       = ["${coalescelist(aws_route_table.database.*.id, aws_route_table.private.*.id)}"]
}

output "redshift_route_table_ids" {
  description = "List of IDs of redshift route tables"
  value       = ["${coalescelist(aws_route_table.redshift.*.id, aws_route_table.private.*.id)}"]
}

output "elasticache_route_table_ids" {
  description = "List of IDs of elasticache route tables"
  value       = ["${coalescelist(aws_route_table.elasticache.*.id, aws_route_table.private.*.id)}"]
}

output "intra_route_table_ids" {
  description = "List of IDs of intra route tables"
  value       = ["${aws_route_table.intra.*.id}"]
}

output "nat_ids" {
  description = "List of allocation ID of Elastic IPs created for AWS NAT Gateway"
  value       = ["${aws_eip.nat.*.id}"]
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = ["${aws_eip.nat.*.public_ip}"]
}

output "natgw_ids" {
  description = "List of NAT Gateway IDs"
  value       = ["${aws_nat_gateway.this.*.id}"]
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = "${element(concat(aws_internet_gateway.this.*.id, list("")), 0)}"
}

output "vgw_id" {
  description = "The ID of the VPN Gateway"
  value       = "${element(concat(aws_vpn_gateway.this.*.id, aws_vpn_gateway_attachment.this.*.vpn_gateway_id, list("")), 0)}"
}

output "default_vpc_id" {
  description = "The ID of the VPC"
  value       = "${element(concat(aws_default_vpc.this.*.id, list("")), 0)}"
}

output "default_vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = "${element(concat(aws_default_vpc.this.*.cidr_block, list("")), 0)}"
}

output "default_vpc_default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = "${element(concat(aws_default_vpc.this.*.default_security_group_id, list("")), 0)}"
}

output "default_vpc_default_network_acl_id" {
  description = "The ID of the default network ACL"
  value       = "${element(concat(aws_default_vpc.this.*.default_network_acl_id, list("")), 0)}"
}

output "default_vpc_default_route_table_id" {
  description = "The ID of the default route table"
  value       = "${element(concat(aws_default_vpc.this.*.default_route_table_id, list("")), 0)}"
}

output "default_vpc_instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  value       = "${element(concat(aws_default_vpc.this.*.instance_tenancy, list("")), 0)}"
}

output "default_vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = "${element(concat(aws_default_vpc.this.*.enable_dns_support, list("")), 0)}"
}

output "default_vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = "${element(concat(aws_default_vpc.this.*.enable_dns_hostnames, list("")), 0)}"
}

output "default_vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = "${element(concat(aws_default_vpc.this.*.main_route_table_id, list("")), 0)}"
}

output "public_network_acl_id" {
  description = "ID of the public network ACL"
  value       = "${element(concat(aws_network_acl.public.*.id, list("")), 0)}"
}

output "private_network_acl_id" {
  description = "ID of the private network ACL"
  value       = "${element(concat(aws_network_acl.private.*.id, list("")), 0)}"
}

output "private_extra_network_acl_id" {
  description = "ID of the private extra network ACL"
  value       = "${element(concat(aws_network_acl.private_extra.*.id, list("")), 0)}"
}

output "intra_network_acl_id" {
  description = "ID of the intra network ACL"
  value       = "${element(concat(aws_network_acl.intra.*.id, list("")), 0)}"
}

output "database_network_acl_id" {
  description = "ID of the database network ACL"
  value       = "${element(concat(aws_network_acl.database.*.id, list("")), 0)}"
}

output "redshift_network_acl_id" {
  description = "ID of the redshift network ACL"
  value       = "${element(concat(aws_network_acl.redshift.*.id, list("")), 0)}"
}

output "elasticache_network_acl_id" {
  description = "ID of the elasticache network ACL"
  value       = "${element(concat(aws_network_acl.elasticache.*.id, list("")), 0)}"
}

####
# VPC Endpoints
####

output "vpc_endpoint_s3_id" {
  description = "The ID of VPC endpoint for S3"
  value       = "${element(concat(aws_vpc_endpoint.s3.*.id, list("")), 0)}"
}

output "vpc_endpoint_s3_pl_id" {
  description = "The prefix list for the S3 VPC endpoint."
  value       = "${element(concat(aws_vpc_endpoint.s3.*.prefix_list_id, list("")), 0)}"
}

output "vpc_endpoint_dynamodb_id" {
  description = "The ID of VPC endpoint for DynamoDB"
  value       = "${element(concat(aws_vpc_endpoint.dynamodb.*.id, list("")), 0)}"
}

output "vpc_endpoint_dynamodb_pl_id" {
  description = "The prefix list for the DynamoDB VPC endpoint."
  value       = "${element(concat(aws_vpc_endpoint.dynamodb.*.prefix_list_id, list("")), 0)}"
}

output "vpc_endpoint_ssm_id" {
  description = "The ID of VPC endpoint for SSM"
  value       = "${element(concat(aws_vpc_endpoint.ssm.*.id, list("")), 0)}"
}

output "vpc_endpoint_ssm_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for SSM."
  value       = "${flatten(aws_vpc_endpoint.ssm.*.network_interface_ids)}"
}

output "vpc_endpoint_ssm_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for SSM."
  value       = "${flatten(aws_vpc_endpoint.ssm.*.dns_entry)}"
}

output "vpc_endpoint_ssmmessages_id" {
  description = "The ID of VPC endpoint for SSMMESSAGES"
  value       = "${element(concat(aws_vpc_endpoint.ssmmessages.*.id, list("")), 0)}"
}

output "vpc_endpoint_ssmmessages_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for SSMMESSAGES."
  value       = "${flatten(aws_vpc_endpoint.ssmmessages.*.network_interface_ids)}"
}

output "vpc_endpoint_ssmmessages_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for SSMMESSAGES."
  value       = "${flatten(aws_vpc_endpoint.ssmmessages.*.dns_entry)}"
}

output "vpc_endpoint_ec2_id" {
  description = "The ID of VPC endpoint for EC2"
  value       = "${element(concat(aws_vpc_endpoint.ec2.*.id, list("")), 0)}"
}

output "vpc_endpoint_ec2_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for EC2"
  value       = "${flatten(aws_vpc_endpoint.ec2.*.network_interface_ids)}"
}

output "vpc_endpoint_ec2_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for EC2."
  value       = "${flatten(aws_vpc_endpoint.ec2.*.dns_entry)}"
}

output "vpc_endpoint_ec2messages_id" {
  description = "The ID of VPC endpoint for EC2MESSAGES"
  value       = "${element(concat(aws_vpc_endpoint.ec2messages.*.id, list("")), 0)}"
}

output "vpc_endpoint_ec2messages_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for EC2MESSAGES"
  value       = "${flatten(aws_vpc_endpoint.ec2messages.*.network_interface_ids)}"
}

output "vpc_endpoint_ec2messages_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for EC2MESSAGES."
  value       = "${flatten(aws_vpc_endpoint.ec2messages.*.dns_entry)}"
}
