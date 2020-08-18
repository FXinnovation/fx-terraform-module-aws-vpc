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
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access\_key | Credentials: AWS access key. | string | n/a | yes |
| secret\_key | Credentials: AWS secret key. Pass this as a variable, never write password in the code. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| database\_network\_acl\_id |  |
| database\_route\_table\_count |  |
| database\_route\_table\_ids |  |
| database\_subnet\_group |  |
| database\_subnets |  |
| database\_subnets\_cidr\_blocks |  |
| database\_subnets\_count |  |
| default\_network\_acl\_id |  |
| default\_route\_table\_id |  |
| default\_security\_group\_id |  |
| default\_vpc\_cidr\_block |  |
| default\_vpc\_default\_network\_acl\_id |  |
| default\_vpc\_default\_route\_table\_id |  |
| default\_vpc\_default\_security\_group\_id |  |
| default\_vpc\_enable\_dns\_hostnames |  |
| default\_vpc\_enable\_dns\_support |  |
| default\_vpc\_id |  |
| default\_vpc\_instance\_tenancy |  |
| default\_vpc\_main\_route\_table\_id |  |
| elasticache\_network\_acl\_id |  |
| elasticache\_route\_table\_count |  |
| elasticache\_route\_table\_ids |  |
| elasticache\_subnet\_group |  |
| elasticache\_subnet\_group\_name |  |
| elasticache\_subnets |  |
| elasticache\_subnets\_cidr\_blocks |  |
| elasticache\_subnets\_count |  |
| igw\_id |  |
| intra\_network\_acl\_id |  |
| intra\_route\_table\_count |  |
| intra\_route\_table\_ids |  |
| intra\_subnets |  |
| intra\_subnets\_cidr\_blocks |  |
| intra\_subnets\_count |  |
| nat\_gateway\_count |  |
| nat\_ids |  |
| nat\_public\_ips |  |
| natgw\_ids |  |
| private\_extra\_network\_acl\_id |  |
| private\_extra\_route\_table\_count |  |
| private\_extra\_route\_table\_ids |  |
| private\_extra\_subnets |  |
| private\_extra\_subnets\_cidr\_blocks |  |
| private\_extra\_subnets\_count |  |
| private\_network\_acl\_id |  |
| private\_route\_table\_count |  |
| private\_route\_table\_ids |  |
| private\_subnets |  |
| private\_subnets\_cidr\_blocks |  |
| private\_subnets\_count |  |
| public\_network\_acl\_id |  |
| public\_route\_table\_count |  |
| public\_route\_table\_ids |  |
| public\_subnets |  |
| public\_subnets\_cidr\_blocks |  |
| public\_subnets\_count |  |
| redshift\_network\_acl\_id |  |
| redshift\_route\_table\_count |  |
| redshift\_route\_table\_ids |  |
| redshift\_subnet\_group |  |
| redshift\_subnets |  |
| redshift\_subnets\_cidr\_blocks |  |
| redshift\_subnets\_count |  |
| total\_subnets\_count |  |
| vgw\_id |  |
| vpc\_cidr\_block |  |
| vpc\_enable\_dns\_hostnames |  |
| vpc\_enable\_dns\_support |  |
| vpc\_endpoint\_cloudwatch\_logs\_dns\_entry |  |
| vpc\_endpoint\_cloudwatch\_logs\_id |  |
| vpc\_endpoint\_cloudwatch\_logs\_network\_interface\_ids |  |
| vpc\_endpoint\_dynamodb\_id |  |
| vpc\_endpoint\_dynamodb\_pl\_id |  |
| vpc\_endpoint\_ec2\_dns\_entry |  |
| vpc\_endpoint\_ec2\_id |  |
| vpc\_endpoint\_ec2\_network\_interface\_ids |  |
| vpc\_endpoint\_ec2messages\_dns\_entry |  |
| vpc\_endpoint\_ec2messages\_id |  |
| vpc\_endpoint\_ec2messages\_network\_interface\_ids |  |
| vpc\_endpoint\_kms\_dns\_entry |  |
| vpc\_endpoint\_kms\_id |  |
| vpc\_endpoint\_kms\_network\_interface\_ids |  |
| vpc\_endpoint\_monitoring\_dns\_entry |  |
| vpc\_endpoint\_monitoring\_id |  |
| vpc\_endpoint\_monitoring\_network\_interface\_ids |  |
| vpc\_endpoint\_s3\_id |  |
| vpc\_endpoint\_s3\_pl\_id |  |
| vpc\_endpoint\_security\_group\_id |  |
| vpc\_endpoint\_ssm\_dns\_entry |  |
| vpc\_endpoint\_ssm\_id |  |
| vpc\_endpoint\_ssm\_network\_interface\_ids |  |
| vpc\_endpoint\_ssmmessages\_dns\_entry |  |
| vpc\_endpoint\_ssmmessages\_id |  |
| vpc\_endpoint\_ssmmessages\_network\_interface\_ids |  |
| vpc\_endpoint\_sts\_dns\_entry |  |
| vpc\_endpoint\_sts\_id |  |
| vpc\_endpoint\_sts\_network\_interface\_ids |  |
| vpc\_id |  |
| vpc\_instance\_tenancy |  |
| vpc\_main\_route\_table\_id |  |
| vpc\_secondary\_cidr\_blocks |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
