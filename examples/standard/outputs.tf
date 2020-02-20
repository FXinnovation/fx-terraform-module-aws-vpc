####
# VPC
####

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.standard.vpc_id
}

####
# Subnets
####

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.standard.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.standard.public_subnets
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.standard.database_subnets
}

output "elasticache_subnets" {
  description = "List of IDs of elasticache subnets"
  value       = module.standard.elasticache_subnets
}

output "redshift_subnets" {
  description = "List of IDs of redshift subnets"
  value       = module.standard.redshift_subnets
}

output "intra_subnets" {
  description = "List of IDs of intra subnets"
  value       = module.standard.intra_subnets
}

####
# NAT gateways
####

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.standard.nat_public_ips
}

####
# VPC endpoints
####

output "vpc_endpoint_ssm_id" {
  description = "The ID of VPC endpoint for SSM"
  value       = module.standard.vpc_endpoint_ssm_id
}

output "vpc_endpoint_ssm_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for SSM."
  value       = module.standard.vpc_endpoint_ssm_network_interface_ids
}

output "vpc_endpoint_ssm_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for SSM."
  value       = module.standard.vpc_endpoint_ssm_dns_entry
}

#####
# Route table
#####

output "public_internet_gateway_route_id" {
  description = "ID of the internet gateway route."
  value       = module.standard.public_internet_gateway_route_id
}

output "public_public_internet_gateway_ipv6_route_id" {
  description = "ID of the IPv6 internet gateway route."
  value       = module.standard.public_public_internet_gateway_ipv6_route_id
}

output "private_nat_gateway_route_ids" {
  description = "IDs of the private nat gateway route."
  value       = module.standard.private_nat_gateway_route_ids
}

output "private_ipv6_egress_route_ids" {
  description = "IDs of the ipv6 egress route."
  value       = module.standard.private_ipv6_egress_route_ids
}

output "public_route_table_association_ids" {
  description = "IDs of the public route table association"
  value       = module.standard.public_route_table_association_ids
}

output "private_route_table_association_ids" {
  description = "IDs of the public route table association"
  value       = module.standard.private_route_table_association_ids
}

output "intra_route_table_association_ids" {
  description = "IDs of the public route table association"
  value       = module.standard.intra_route_table_association_ids
}
