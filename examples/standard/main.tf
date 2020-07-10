provider "aws" {
  version    = "~> 2.2.0"
  region     = "eu-west-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = "${module.standard.vpc_id}"
}

module "standard" {
  source = "../../"

  name = "tftest-example-vpc"

  cidr = "10.10.0.0/16"

  azs                   = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets       = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  private_extra_subnets = ["10.10.61.0/24", "10.10.62.0/24", "10.10.63.0/24"]
  public_subnets        = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]
  database_subnets      = ["10.10.21.0/24", "10.10.22.0/24", "10.10.23.0/24"]
  elasticache_subnets   = ["10.10.31.0/24", "10.10.32.0/24", "10.10.33.0/24"]
  redshift_subnets      = ["10.10.41.0/24", "10.10.42.0/24", "10.10.43.0/24"]
  intra_subnets         = ["10.10.51.0/24", "10.10.52.0/24", "10.10.53.0/24"]

  public_route_table_suffix        = "tftest-pubrte"
  private_route_table_suffix       = "tftest-pvrte"
  private_extra_route_table_suffix = "tftest-pverte"
  database_route_table_suffix      = "tftest-datrte"
  elasticache_route_table_suffix   = "tftest-elarte"
  redshift_route_table_suffix      = "tftest-redrte"
  intra_route_table_suffix         = "tftest-intrte"

  create_database_subnet_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  enable_vpn_gateway = true

  enable_dhcp_options              = true
  dhcp_options_domain_name         = "tftest.service.consul"
  dhcp_options_domain_name_servers = ["127.0.0.1", "10.10.0.2"]

  enable_s3_endpoint = true

  enable_dynamodb_endpoint = true

  enable_kms_endpoint = true

  enable_ssm_endpoint              = true
  ssm_endpoint_private_dns_enabled = true
  ssm_endpoint_security_group_ids  = ["${data.aws_security_group.default.id}"] # ssm_endpoint_subnet_ids = ["..."]

  enable_ssmmessages_endpoint              = true
  ssmmessages_endpoint_private_dns_enabled = true
  ssmmessages_endpoint_security_group_ids  = ["${data.aws_security_group.default.id}"]

  enable_ec2_endpoint              = true
  ec2_endpoint_private_dns_enabled = true

  enable_ec2messages_endpoint              = true
  ec2messages_endpoint_private_dns_enabled = true

  enable_ecr_api_endpoint              = true
  ecr_api_endpoint_private_dns_enabled = true
  ecr_api_endpoint_security_group_ids  = ["${data.aws_security_group.default.id}"]

  enable_ecr_dkr_endpoint              = true
  ecr_dkr_endpoint_private_dns_enabled = true
  ecr_dkr_endpoint_security_group_ids  = ["${data.aws_security_group.default.id}"]

  enable_cloudwatch_logs_endpoint              = true
  cloudwatch_logs_endpoint_private_dns_enabled = true
  cloudwatch_logs_endpoint_security_group_ids  = ["${data.aws_security_group.default.id}"]

  tags = {
    Owner       = "user"
    Environment = "staging"
    Name        = "tftest-vpc"
  }
}
