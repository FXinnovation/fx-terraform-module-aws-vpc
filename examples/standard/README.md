# VPC module standard test

Creates a complete VPC.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money (AWS Elastic IP, for example). Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| aws | ~> 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_key | Credentials: AWS access key. | `string` | n/a | yes |
| secret\_key | Credentials: AWS secret key. Pass this as a variable, never write password in the code. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| database\_network\_acl\_id | n/a |
| database\_route\_table\_count | n/a |
| database\_route\_table\_ids | n/a |
| database\_subnet\_group | n/a |
| database\_subnets | n/a |
| database\_subnets\_cidr\_blocks | n/a |
| database\_subnets\_count | n/a |
| default\_network\_acl\_id | n/a |
| default\_route\_table\_id | n/a |
| default\_security\_group\_id | n/a |
| default\_vpc\_cidr\_block | n/a |
| default\_vpc\_default\_network\_acl\_id | n/a |
| default\_vpc\_default\_route\_table\_id | n/a |
| default\_vpc\_default\_security\_group\_id | n/a |
| default\_vpc\_enable\_dns\_hostnames | n/a |
| default\_vpc\_enable\_dns\_support | n/a |
| default\_vpc\_id | n/a |
| default\_vpc\_instance\_tenancy | n/a |
| default\_vpc\_main\_route\_table\_id | n/a |
| elasticache\_network\_acl\_id | n/a |
| elasticache\_route\_table\_count | n/a |
| elasticache\_route\_table\_ids | n/a |
| elasticache\_subnet\_group | n/a |
| elasticache\_subnet\_group\_name | n/a |
| elasticache\_subnets | n/a |
| elasticache\_subnets\_cidr\_blocks | n/a |
| elasticache\_subnets\_count | n/a |
| igw\_id | n/a |
| intra\_network\_acl\_id | n/a |
| intra\_route\_table\_count | n/a |
| intra\_route\_table\_ids | n/a |
| intra\_subnets | n/a |
| intra\_subnets\_cidr\_blocks | n/a |
| intra\_subnets\_count | n/a |
| nat\_gateway\_count | n/a |
| nat\_ids | n/a |
| nat\_public\_ips | n/a |
| natgw\_ids | n/a |
| private\_extra\_network\_acl\_id | n/a |
| private\_extra\_route\_table\_count | n/a |
| private\_extra\_route\_table\_ids | n/a |
| private\_extra\_subnets | n/a |
| private\_extra\_subnets\_cidr\_blocks | n/a |
| private\_extra\_subnets\_count | n/a |
| private\_network\_acl\_id | n/a |
| private\_route\_table\_count | n/a |
| private\_route\_table\_ids | n/a |
| private\_subnets | n/a |
| private\_subnets\_cidr\_blocks | n/a |
| private\_subnets\_count | n/a |
| public\_network\_acl\_id | n/a |
| public\_route\_table\_count | n/a |
| public\_route\_table\_ids | n/a |
| public\_subnets | n/a |
| public\_subnets\_cidr\_blocks | n/a |
| public\_subnets\_count | n/a |
| redshift\_network\_acl\_id | n/a |
| redshift\_route\_table\_count | n/a |
| redshift\_route\_table\_ids | n/a |
| redshift\_subnet\_group | n/a |
| redshift\_subnets | n/a |
| redshift\_subnets\_cidr\_blocks | n/a |
| redshift\_subnets\_count | n/a |
| total\_subnets\_count | n/a |
| vgw\_id | n/a |
| vpc\_cidr\_block | n/a |
| vpc\_enable\_dns\_hostnames | n/a |
| vpc\_enable\_dns\_support | n/a |
| vpc\_endpoint\_cloudwatch\_logs\_dns\_entry | n/a |
| vpc\_endpoint\_cloudwatch\_logs\_id | n/a |
| vpc\_endpoint\_cloudwatch\_logs\_network\_interface\_ids | n/a |
| vpc\_endpoint\_dynamodb\_id | n/a |
| vpc\_endpoint\_dynamodb\_pl\_id | n/a |
| vpc\_endpoint\_ec2\_dns\_entry | n/a |
| vpc\_endpoint\_ec2\_id | n/a |
| vpc\_endpoint\_ec2\_network\_interface\_ids | n/a |
| vpc\_endpoint\_ec2messages\_dns\_entry | n/a |
| vpc\_endpoint\_ec2messages\_id | n/a |
| vpc\_endpoint\_ec2messages\_network\_interface\_ids | n/a |
| vpc\_endpoint\_kms\_dns\_entry | n/a |
| vpc\_endpoint\_kms\_id | n/a |
| vpc\_endpoint\_kms\_network\_interface\_ids | n/a |
| vpc\_endpoint\_monitoring\_dns\_entry | n/a |
| vpc\_endpoint\_monitoring\_id | n/a |
| vpc\_endpoint\_monitoring\_network\_interface\_ids | n/a |
| vpc\_endpoint\_s3\_id | n/a |
| vpc\_endpoint\_s3\_pl\_id | n/a |
| vpc\_endpoint\_security\_group\_id | n/a |
| vpc\_endpoint\_ssm\_dns\_entry | n/a |
| vpc\_endpoint\_ssm\_id | n/a |
| vpc\_endpoint\_ssm\_network\_interface\_ids | n/a |
| vpc\_endpoint\_ssmmessages\_dns\_entry | n/a |
| vpc\_endpoint\_ssmmessages\_id | n/a |
| vpc\_endpoint\_ssmmessages\_network\_interface\_ids | n/a |
| vpc\_endpoint\_sts\_dns\_entry | n/a |
| vpc\_endpoint\_sts\_id | n/a |
| vpc\_endpoint\_sts\_network\_interface\_ids | n/a |
| vpc\_id | n/a |
| vpc\_instance\_tenancy | n/a |
| vpc\_main\_route\_table\_id | n/a |
| vpc\_secondary\_cidr\_blocks | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
