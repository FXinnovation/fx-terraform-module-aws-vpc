# Terraform VPC module

## IMPORTANT NOTE
This module is a copy of the [public Terraform VPC module](https://github.com/terraform-aws-modules/terraform-aws-vpc/).
It brings:

- More outputs (on route attachements and route table association)

This module didn't keep changes from the `0.4.3` (extra subnets, output count, AZ prefix).

This module is not to be deployed directly.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | ~> 3.1 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| amazon\_side\_asn | The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the virtual private gateway is created with the current default Amazon ASN. | `string` | `"64512"` | no |
| apigw\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for API GW endpoint | `bool` | `false` | no |
| apigw\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for API GW  endpoint | `list(string)` | `[]` | no |
| apigw\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for API GW endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| appmesh\_envoy\_management\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for AppMesh endpoint | `bool` | `false` | no |
| appmesh\_envoy\_management\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for AppMesh endpoint | `list(string)` | `[]` | no |
| appmesh\_envoy\_management\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for AppMesh endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| appstream\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for AppStream endpoint | `bool` | `false` | no |
| appstream\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for AppStream endpoint | `list(string)` | `[]` | no |
| appstream\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for AppStream endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| assign\_ipv6\_address\_on\_creation | Assign IPv6 address on subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map\_public\_ip\_on\_launch | `bool` | `false` | no |
| athena\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Athena endpoint | `bool` | `false` | no |
| athena\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Athena endpoint | `list(string)` | `[]` | no |
| athena\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Athena endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| azs | A list of availability zones in the region | `list(string)` | `[]` | no |
| cidr | The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden | `string` | `"0.0.0.0/0"` | no |
| cloud\_directory\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Cloud Directory endpoint | `bool` | `false` | no |
| cloud\_directory\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Cloud Directory endpoint | `list(string)` | `[]` | no |
| cloud\_directory\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Cloud Directory endpoint. Only a single subnet within an AZ is supported. Ifomitted, private subnets will be used. | `list(string)` | `[]` | no |
| cloudformation\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Cloudformation endpoint | `bool` | `false` | no |
| cloudformation\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Cloudformation endpoint | `list(string)` | `[]` | no |
| cloudformation\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Cloudformation endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| cloudtrail\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for CloudTrail endpoint | `bool` | `false` | no |
| cloudtrail\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for CloudTrail endpoint | `list(string)` | `[]` | no |
| cloudtrail\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for CloudTrail endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| codebuild\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Codebuild endpoint | `bool` | `false` | no |
| codebuild\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Codebuild endpoint | `list` | `[]` | no |
| codebuild\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Codebuilt endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list` | `[]` | no |
| codecommit\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Codecommit endpoint | `bool` | `false` | no |
| codecommit\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Codecommit endpoint | `list` | `[]` | no |
| codecommit\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Codecommit endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list` | `[]` | no |
| codepipeline\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for CodePipeline endpoint | `bool` | `false` | no |
| codepipeline\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for CodePipeline endpoint | `list(string)` | `[]` | no |
| codepipeline\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for CodePipeline endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| config\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for config endpoint | `bool` | `false` | no |
| config\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for config endpoint | `list` | `[]` | no |
| config\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for config endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list` | `[]` | no |
| create\_database\_internet\_gateway\_route | Controls if an internet gateway route for public database access should be created | `bool` | `false` | no |
| create\_database\_nat\_gateway\_route | Controls if a nat gateway route should be created to give internet access to the database subnets | `bool` | `false` | no |
| create\_database\_subnet\_group | Controls if database subnet group should be created | `bool` | `true` | no |
| create\_database\_subnet\_route\_table | Controls if separate route table for database should be created | `bool` | `false` | no |
| create\_elasticache\_subnet\_group | Controls if elasticache subnet group should be created | `bool` | `true` | no |
| create\_elasticache\_subnet\_route\_table | Controls if separate route table for elasticache should be created | `bool` | `false` | no |
| create\_redshift\_subnet\_group | Controls if redshift subnet group should be created | `bool` | `true` | no |
| create\_redshift\_subnet\_route\_table | Controls if separate route table for redshift should be created | `bool` | `false` | no |
| create\_vpc | Controls if VPC should be created (it affects almost all resources) | `bool` | `true` | no |
| customer\_gateway\_tags | Additional tags for the Customer Gateway | `map(string)` | `{}` | no |
| customer\_gateways | Maps of Customer Gateway's attributes (BGP ASN and Gateway's Internet-routable external IP address) | `map(map(any))` | `{}` | no |
| database\_acl\_tags | Additional tags for the database subnets network ACL | `map(string)` | `{}` | no |
| database\_dedicated\_network\_acl | Whether to use dedicated network ACL (not default) and custom rules for database subnets | `bool` | `false` | no |
| database\_inbound\_acl\_rules | Database subnets inbound network ACL rules | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| database\_outbound\_acl\_rules | Database subnets outbound network ACL rules | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| database\_route\_table\_tags | Additional tags for the database route tables | `map(string)` | `{}` | no |
| database\_subnet\_assign\_ipv6\_address\_on\_creation | Assign IPv6 address on database subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map\_public\_ip\_on\_launch | `bool` | `null` | no |
| database\_subnet\_group\_tags | Additional tags for the database subnet group | `map(string)` | `{}` | no |
| database\_subnet\_ipv6\_prefixes | Assigns IPv6 database subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list | `list(any)` | `[]` | no |
| database\_subnet\_suffix | Suffix to append to database subnets name | `string` | `"db"` | no |
| database\_subnet\_tags | Additional tags for the database subnets | `map(string)` | `{}` | no |
| database\_subnets | A list of database subnets | `list(string)` | `[]` | no |
| default\_network\_acl\_egress | List of maps of egress rules to set on the Default Network ACL | `list(map(string))` | <pre>[<br>  {<br>    "action": "allow",<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_no": 100,<br>    "to_port": 0<br>  },<br>  {<br>    "action": "allow",<br>    "from_port": 0,<br>    "ipv6_cidr_block": "::/0",<br>    "protocol": "-1",<br>    "rule_no": 101,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| default\_network\_acl\_ingress | List of maps of ingress rules to set on the Default Network ACL | `list(map(string))` | <pre>[<br>  {<br>    "action": "allow",<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_no": 100,<br>    "to_port": 0<br>  },<br>  {<br>    "action": "allow",<br>    "from_port": 0,<br>    "ipv6_cidr_block": "::/0",<br>    "protocol": "-1",<br>    "rule_no": 101,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| default\_network\_acl\_name | Name to be used on the Default Network ACL | `string` | `""` | no |
| default\_network\_acl\_tags | Additional tags for the Default Network ACL | `map(string)` | `{}` | no |
| default\_vpc\_enable\_classiclink | Should be true to enable ClassicLink in the Default VPC | `bool` | `false` | no |
| default\_vpc\_enable\_dns\_hostnames | Should be true to enable DNS hostnames in the Default VPC | `bool` | `false` | no |
| default\_vpc\_enable\_dns\_support | Should be true to enable DNS support in the Default VPC | `bool` | `true` | no |
| default\_vpc\_name | Name to be used on the Default VPC | `string` | `""` | no |
| default\_vpc\_tags | Additional tags for the Default VPC | `map(string)` | `{}` | no |
| dhcp\_options\_domain\_name | Specifies DNS name for DHCP options set (requires enable\_dhcp\_options set to true) | `string` | `""` | no |
| dhcp\_options\_domain\_name\_servers | Specify a list of DNS server addresses for DHCP options set, default to AWS provided (requires enable\_dhcp\_options set to true) | `list(string)` | <pre>[<br>  "AmazonProvidedDNS"<br>]</pre> | no |
| dhcp\_options\_netbios\_name\_servers | Specify a list of netbios servers for DHCP options set (requires enable\_dhcp\_options set to true) | `list(string)` | `[]` | no |
| dhcp\_options\_netbios\_node\_type | Specify netbios node\_type for DHCP options set (requires enable\_dhcp\_options set to true) | `string` | `""` | no |
| dhcp\_options\_ntp\_servers | Specify a list of NTP servers for DHCP options set (requires enable\_dhcp\_options set to true) | `list(string)` | `[]` | no |
| dhcp\_options\_tags | Additional tags for the DHCP option set (requires enable\_dhcp\_options set to true) | `map(string)` | `{}` | no |
| ec2\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for EC2 endpoint | `bool` | `false` | no |
| ec2\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for EC2 endpoint | `list(string)` | `[]` | no |
| ec2\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for EC2 endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| ec2messages\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for EC2MESSAGES endpoint | `bool` | `false` | no |
| ec2messages\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for EC2MESSAGES endpoint | `list(string)` | `[]` | no |
| ec2messages\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for EC2MESSAGES endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| ecr\_api\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for ECR API endpoint | `bool` | `false` | no |
| ecr\_api\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for ECR API endpoint | `list(string)` | `[]` | no |
| ecr\_api\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for ECR api endpoint. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| ecr\_dkr\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for ECR DKR endpoint | `bool` | `false` | no |
| ecr\_dkr\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for ECR DKR endpoint | `list(string)` | `[]` | no |
| ecr\_dkr\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for ECR dkr endpoint. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| ecs\_agent\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for ECS Agent endpoint | `bool` | `false` | no |
| ecs\_agent\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for ECS Agent endpoint | `list(string)` | `[]` | no |
| ecs\_agent\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for ECS Agent endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| ecs\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for ECS endpoint | `bool` | `false` | no |
| ecs\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for ECS endpoint | `list(string)` | `[]` | no |
| ecs\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for ECS endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| ecs\_telemetry\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for ECS Telemetry endpoint | `bool` | `false` | no |
| ecs\_telemetry\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for ECS Telemetry endpoint | `list(string)` | `[]` | no |
| ecs\_telemetry\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for ECS Telemetry endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| efs\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for EFS endpoint | `bool` | `false` | no |
| efs\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for EFS endpoint | `list(string)` | `[]` | no |
| efs\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for EFS endpoint. Only a single subnet within an AZ is supported. Ifomitted, private subnets will be used. | `list(string)` | `[]` | no |
| elasticache\_acl\_tags | Additional tags for the elasticache subnets network ACL | `map(string)` | `{}` | no |
| elasticache\_dedicated\_network\_acl | Whether to use dedicated network ACL (not default) and custom rules for elasticache subnets | `bool` | `false` | no |
| elasticache\_inbound\_acl\_rules | Elasticache subnets inbound network ACL rules | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| elasticache\_outbound\_acl\_rules | Elasticache subnets outbound network ACL rules | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| elasticache\_route\_table\_tags | Additional tags for the elasticache route tables | `map(string)` | `{}` | no |
| elasticache\_subnet\_assign\_ipv6\_address\_on\_creation | Assign IPv6 address on elasticache subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map\_public\_ip\_on\_launch | `bool` | `null` | no |
| elasticache\_subnet\_ipv6\_prefixes | Assigns IPv6 elasticache subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list | `list(any)` | `[]` | no |
| elasticache\_subnet\_suffix | Suffix to append to elasticache subnets name | `string` | `"elasticache"` | no |
| elasticache\_subnet\_tags | Additional tags for the elasticache subnets | `map(string)` | `{}` | no |
| elasticache\_subnets | A list of elasticache subnets | `list(string)` | `[]` | no |
| elasticloadbalancing\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Elastic Load Balancing endpoint | `bool` | `false` | no |
| elasticloadbalancing\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Elastic Load Balancing endpoint | `list(string)` | `[]` | no |
| elasticloadbalancing\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Elastic Load Balancing endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| enable\_apigw\_endpoint | Should be true if you want to provision an api gateway endpoint to the VPC | `bool` | `false` | no |
| enable\_appmesh\_envoy\_management\_endpoint | Should be true if you want to provision a AppMesh endpoint to the VPC | `bool` | `false` | no |
| enable\_appstream\_endpoint | Should be true if you want to provision a AppStream endpoint to the VPC | `bool` | `false` | no |
| enable\_athena\_endpoint | Should be true if you want to provision a Athena endpoint to the VPC | `bool` | `false` | no |
| enable\_classiclink | Should be true to enable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. | `bool` | `null` | no |
| enable\_classiclink\_dns\_support | Should be true to enable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic. | `bool` | `null` | no |
| enable\_cloud\_directory\_endpoint | Should be true if you want to provision an Cloud Directory endpoint to the VPC | `bool` | `false` | no |
| enable\_cloudformation\_endpoint | Should be true if you want to provision a Cloudformation endpoint to the VPC | `bool` | `false` | no |
| enable\_cloudtrail\_endpoint | Should be true if you want to provision a CloudTrail endpoint to the VPC | `bool` | `false` | no |
| enable\_codebuild\_endpoint | Should be true if you want to provision an Codebuild endpoint to the VPC | `bool` | `false` | no |
| enable\_codecommit\_endpoint | Should be true if you want to provision an Codecommit endpoint to the VPC | `bool` | `false` | no |
| enable\_codepipeline\_endpoint | Should be true if you want to provision a CodePipeline endpoint to the VPC | `bool` | `false` | no |
| enable\_config\_endpoint | Should be true if you want to provision an config endpoint to the VPC | `bool` | `false` | no |
| enable\_dhcp\_options | Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type | `bool` | `false` | no |
| enable\_dns\_hostnames | Should be true to enable DNS hostnames in the VPC | `bool` | `false` | no |
| enable\_dns\_support | Should be true to enable DNS support in the VPC | `bool` | `true` | no |
| enable\_dynamodb\_endpoint | Should be true if you want to provision a DynamoDB endpoint to the VPC | `bool` | `false` | no |
| enable\_ec2\_endpoint | Should be true if you want to provision an EC2 endpoint to the VPC | `bool` | `false` | no |
| enable\_ec2messages\_endpoint | Should be true if you want to provision an EC2MESSAGES endpoint to the VPC | `bool` | `false` | no |
| enable\_ecr\_api\_endpoint | Should be true if you want to provision an ecr api endpoint to the VPC | `bool` | `false` | no |
| enable\_ecr\_dkr\_endpoint | Should be true if you want to provision an ecr dkr endpoint to the VPC | `bool` | `false` | no |
| enable\_ecs\_agent\_endpoint | Should be true if you want to provision a ECS Agent endpoint to the VPC | `bool` | `false` | no |
| enable\_ecs\_endpoint | Should be true if you want to provision a ECS endpoint to the VPC | `bool` | `false` | no |
| enable\_ecs\_telemetry\_endpoint | Should be true if you want to provision a ECS Telemetry endpoint to the VPC | `bool` | `false` | no |
| enable\_efs\_endpoint | Should be true if you want to provision an EFS endpoint to the VPC | `bool` | `false` | no |
| enable\_elasticloadbalancing\_endpoint | Should be true if you want to provision a Elastic Load Balancing endpoint to the VPC | `bool` | `false` | no |
| enable\_events\_endpoint | Should be true if you want to provision a CloudWatch Events endpoint to the VPC | `bool` | `false` | no |
| enable\_git\_codecommit\_endpoint | Should be true if you want to provision an Git Codecommit endpoint to the VPC | `bool` | `false` | no |
| enable\_glue\_endpoint | Should be true if you want to provision a Glue endpoint to the VPC | `bool` | `false` | no |
| enable\_ipv6 | Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. | `bool` | `false` | no |
| enable\_kinesis\_firehose\_endpoint | Should be true if you want to provision a Kinesis Firehose endpoint to the VPC | `bool` | `false` | no |
| enable\_kinesis\_streams\_endpoint | Should be true if you want to provision a Kinesis Streams endpoint to the VPC | `bool` | `false` | no |
| enable\_kms\_endpoint | Should be true if you want to provision a KMS endpoint to the VPC | `bool` | `false` | no |
| enable\_lambda\_endpoint | Should be true if you want to provision an Cloud Directory endpoint to the VPC | `bool` | `false` | no |
| enable\_logs\_endpoint | Should be true if you want to provision a CloudWatch Logs endpoint to the VPC | `bool` | `false` | no |
| enable\_monitoring\_endpoint | Should be true if you want to provision a CloudWatch Monitoring endpoint to the VPC | `bool` | `false` | no |
| enable\_nat\_gateway | Should be true if you want to provision NAT Gateways for each of your private networks | `bool` | `false` | no |
| enable\_public\_redshift | Controls if redshift should have public routing table | `bool` | `false` | no |
| enable\_rekognition\_endpoint | Should be true if you want to provision a Rekognition endpoint to the VPC | `bool` | `false` | no |
| enable\_s3\_endpoint | Should be true if you want to provision an S3 endpoint to the VPC | `bool` | `false` | no |
| enable\_sagemaker\_api\_endpoint | Should be true if you want to provision a SageMaker API endpoint to the VPC | `bool` | `false` | no |
| enable\_sagemaker\_notebook\_endpoint | Should be true if you want to provision a Sagemaker Notebook endpoint to the VPC | `bool` | `false` | no |
| enable\_sagemaker\_runtime\_endpoint | Should be true if you want to provision a SageMaker Runtime endpoint to the VPC | `bool` | `false` | no |
| enable\_secretsmanager\_endpoint | Should be true if you want to provision an Secrets Manager endpoint to the VPC | `bool` | `false` | no |
| enable\_servicecatalog\_endpoint | Should be true if you want to provision a Service Catalog endpoint to the VPC | `bool` | `false` | no |
| enable\_sns\_endpoint | Should be true if you want to provision a SNS endpoint to the VPC | `bool` | `false` | no |
| enable\_sqs\_endpoint | Should be true if you want to provision an SQS endpoint to the VPC | `bool` | `false` | no |
| enable\_ssm\_endpoint | Should be true if you want to provision an SSM endpoint to the VPC | `bool` | `false` | no |
| enable\_ssmmessages\_endpoint | Should be true if you want to provision a SSMMESSAGES endpoint to the VPC | `bool` | `false` | no |
| enable\_storagegateway\_endpoint | Should be true if you want to provision a Storage Gateway endpoint to the VPC | `bool` | `false` | no |
| enable\_sts\_endpoint | Should be true if you want to provision a STS endpoint to the VPC | `bool` | `false` | no |
| enable\_transfer\_endpoint | Should be true if you want to provision a Transfer endpoint to the VPC | `bool` | `false` | no |
| enable\_transferserver\_endpoint | Should be true if you want to provision a Transfer Server endpoint to the VPC | `bool` | `false` | no |
| enable\_vpn\_gateway | Should be true if you want to create a new VPN Gateway resource and attach it to the VPC | `bool` | `false` | no |
| events\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for CloudWatch Events endpoint | `bool` | `false` | no |
| events\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for CloudWatch Events endpoint | `list(string)` | `[]` | no |
| events\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for CloudWatch Events endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| external\_nat\_ip\_ids | List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse\_nat\_ips) | `list(string)` | `[]` | no |
| git\_codecommit\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Git Codecommit endpoint | `bool` | `false` | no |
| git\_codecommit\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Git Codecommit endpoint | `list` | `[]` | no |
| git\_codecommit\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Git Codecommit endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list` | `[]` | no |
| glue\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Glue endpoint | `bool` | `false` | no |
| glue\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Glue endpoint | `list(string)` | `[]` | no |
| glue\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Glue endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| igw\_tags | Additional tags for the internet gateway | `map(string)` | `{}` | no |
| instance\_tenancy | A tenancy option for instances launched into the VPC | `string` | `"default"` | no |
| intra\_acl\_tags | Additional tags for the intra subnets network ACL | `map(string)` | `{}` | no |
| intra\_dedicated\_network\_acl | Whether to use dedicated network ACL (not default) and custom rules for intra subnets | `bool` | `false` | no |
| intra\_inbound\_acl\_rules | Intra subnets inbound network ACLs | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| intra\_outbound\_acl\_rules | Intra subnets outbound network ACLs | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| intra\_route\_table\_tags | Additional tags for the intra route tables | `map(string)` | `{}` | no |
| intra\_subnet\_assign\_ipv6\_address\_on\_creation | Assign IPv6 address on intra subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map\_public\_ip\_on\_launch | `bool` | `null` | no |
| intra\_subnet\_ipv6\_prefixes | Assigns IPv6 intra subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list | `list(any)` | `[]` | no |
| intra\_subnet\_suffix | Suffix to append to intra subnets name | `string` | `"intra"` | no |
| intra\_subnet\_tags | Additional tags for the intra subnets | `map(string)` | `{}` | no |
| intra\_subnets | A list of intra subnets | `list(string)` | `[]` | no |
| kinesis\_firehose\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Kinesis Firehose endpoint | `bool` | `false` | no |
| kinesis\_firehose\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Kinesis Firehose endpoint | `list(string)` | `[]` | no |
| kinesis\_firehose\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Kinesis Firehose endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| kinesis\_streams\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Kinesis Streams endpoint | `bool` | `false` | no |
| kinesis\_streams\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Kinesis Streams endpoint | `list(string)` | `[]` | no |
| kinesis\_streams\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Kinesis Streams endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| kms\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for KMS endpoint | `bool` | `false` | no |
| kms\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for KMS endpoint | `list(string)` | `[]` | no |
| kms\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for KMS endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| lambda\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Cloud Directory endpoint | `bool` | `false` | no |
| lambda\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Lambda endpoint | `list(string)` | `[]` | no |
| lambda\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Cloud Directory endpoint. Only a single subnet within an AZ is supported. Ifomitted, private subnets will be used. | `list(string)` | `[]` | no |
| logs\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for CloudWatch Logs endpoint | `bool` | `false` | no |
| logs\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for CloudWatch Logs endpoint | `list(string)` | `[]` | no |
| logs\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for CloudWatch Logs endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| manage\_default\_network\_acl | Should be true to adopt and manage Default Network ACL | `bool` | `false` | no |
| manage\_default\_vpc | Should be true to adopt and manage Default VPC | `bool` | `false` | no |
| map\_public\_ip\_on\_launch | Should be false if you do not want to auto-assign public IP on launch | `bool` | `true` | no |
| monitoring\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for CloudWatch Monitoring endpoint | `bool` | `false` | no |
| monitoring\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for CloudWatch Monitoring endpoint | `list(string)` | `[]` | no |
| monitoring\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for CloudWatch Monitoring endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| name | Name to be used on all the resources as identifier | `string` | `""` | no |
| nat\_eip\_tags | Additional tags for the NAT EIP | `map(string)` | `{}` | no |
| nat\_gateway\_tags | Additional tags for the NAT gateways | `map(string)` | `{}` | no |
| one\_nat\_gateway\_per\_az | Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`. | `bool` | `false` | no |
| private\_acl\_tags | Additional tags for the private subnets network ACL | `map(string)` | `{}` | no |
| private\_dedicated\_network\_acl | Whether to use dedicated network ACL (not default) and custom rules for private subnets | `bool` | `false` | no |
| private\_inbound\_acl\_rules | Private subnets inbound network ACLs | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| private\_outbound\_acl\_rules | Private subnets outbound network ACLs | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| private\_route\_table\_tags | Additional tags for the private route tables | `map(string)` | `{}` | no |
| private\_subnet\_assign\_ipv6\_address\_on\_creation | Assign IPv6 address on private subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map\_public\_ip\_on\_launch | `bool` | `null` | no |
| private\_subnet\_ipv6\_prefixes | Assigns IPv6 private subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list | `list(any)` | `[]` | no |
| private\_subnet\_suffix | Suffix to append to private subnets name | `string` | `"private"` | no |
| private\_subnet\_tags | Additional tags for the private subnets | `map(string)` | `{}` | no |
| private\_subnets | A list of private subnets inside the VPC | `list(string)` | `[]` | no |
| propagate\_private\_route\_tables\_vgw | Should be true if you want route table propagation | `bool` | `false` | no |
| propagate\_public\_route\_tables\_vgw | Should be true if you want route table propagation | `bool` | `false` | no |
| public\_acl\_tags | Additional tags for the public subnets network ACL | `map(string)` | `{}` | no |
| public\_dedicated\_network\_acl | Whether to use dedicated network ACL (not default) and custom rules for public subnets | `bool` | `false` | no |
| public\_inbound\_acl\_rules | Public subnets inbound network ACLs | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| public\_outbound\_acl\_rules | Public subnets outbound network ACLs | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| public\_route\_table\_tags | Additional tags for the public route tables | `map(string)` | `{}` | no |
| public\_subnet\_assign\_ipv6\_address\_on\_creation | Assign IPv6 address on public subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map\_public\_ip\_on\_launch | `bool` | `null` | no |
| public\_subnet\_ipv6\_prefixes | Assigns IPv6 public subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list | `list(any)` | `[]` | no |
| public\_subnet\_suffix | Suffix to append to public subnets name | `string` | `"public"` | no |
| public\_subnet\_tags | Additional tags for the public subnets | `map(string)` | `{}` | no |
| public\_subnets | A list of public subnets inside the VPC | `list(string)` | `[]` | no |
| redshift\_acl\_tags | Additional tags for the redshift subnets network ACL | `map(string)` | `{}` | no |
| redshift\_dedicated\_network\_acl | Whether to use dedicated network ACL (not default) and custom rules for redshift subnets | `bool` | `false` | no |
| redshift\_inbound\_acl\_rules | Redshift subnets inbound network ACL rules | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| redshift\_outbound\_acl\_rules | Redshift subnets outbound network ACL rules | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| redshift\_route\_table\_tags | Additional tags for the redshift route tables | `map(string)` | `{}` | no |
| redshift\_subnet\_assign\_ipv6\_address\_on\_creation | Assign IPv6 address on redshift subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map\_public\_ip\_on\_launch | `bool` | `null` | no |
| redshift\_subnet\_group\_tags | Additional tags for the redshift subnet group | `map(string)` | `{}` | no |
| redshift\_subnet\_ipv6\_prefixes | Assigns IPv6 redshift subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list | `list(any)` | `[]` | no |
| redshift\_subnet\_suffix | Suffix to append to redshift subnets name | `string` | `"redshift"` | no |
| redshift\_subnet\_tags | Additional tags for the redshift subnets | `map(string)` | `{}` | no |
| redshift\_subnets | A list of redshift subnets | `list(string)` | `[]` | no |
| rekognition\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Rekognition endpoint | `bool` | `false` | no |
| rekognition\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Rekognition endpoint | `list(string)` | `[]` | no |
| rekognition\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Rekognition endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| reuse\_nat\_ips | Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external\_nat\_ip\_ids' variable | `bool` | `false` | no |
| sagemaker\_api\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for SageMaker API endpoint | `bool` | `false` | no |
| sagemaker\_api\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for SageMaker API endpoint | `list(string)` | `[]` | no |
| sagemaker\_api\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for SageMaker API endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| sagemaker\_notebook\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Sagemaker Notebook endpoint | `bool` | `false` | no |
| sagemaker\_notebook\_endpoint\_region | Region to use for Sagemaker Notebook endpoint | `string` | `""` | no |
| sagemaker\_notebook\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Sagemaker Notebook endpoint | `list(string)` | `[]` | no |
| sagemaker\_notebook\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Sagemaker Notebook endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| sagemaker\_runtime\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for SageMaker Runtime endpoint | `bool` | `false` | no |
| sagemaker\_runtime\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for SageMaker Runtime endpoint | `list(string)` | `[]` | no |
| sagemaker\_runtime\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for SageMaker Runtime endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| secondary\_cidr\_blocks | List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool | `list(string)` | `[]` | no |
| secretsmanager\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Secrets Manager endpoint | `bool` | `false` | no |
| secretsmanager\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Secrets Manager endpoint | `list(string)` | `[]` | no |
| secretsmanager\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Secrets Manager endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| servicecatalog\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Service Catalog endpoint | `bool` | `false` | no |
| servicecatalog\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Service Catalog endpoint | `list(string)` | `[]` | no |
| servicecatalog\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Service Catalog endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| single\_nat\_gateway | Should be true if you want to provision a single shared NAT Gateway across all of your private networks | `bool` | `false` | no |
| sns\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for SNS endpoint | `bool` | `false` | no |
| sns\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for SNS endpoint | `list(string)` | `[]` | no |
| sns\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for SNS endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| sqs\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for SQS endpoint | `bool` | `false` | no |
| sqs\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for SQS endpoint | `list` | `[]` | no |
| sqs\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for SQS endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list` | `[]` | no |
| ssm\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for SSM endpoint | `bool` | `false` | no |
| ssm\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for SSM endpoint | `list(string)` | `[]` | no |
| ssm\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for SSM endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| ssmmessages\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for SSMMESSAGES endpoint | `bool` | `false` | no |
| ssmmessages\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for SSMMESSAGES endpoint | `list(string)` | `[]` | no |
| ssmmessages\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for SSMMESSAGES endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| storagegateway\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Storage Gateway endpoint | `bool` | `false` | no |
| storagegateway\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Storage Gateway endpoint | `list(string)` | `[]` | no |
| storagegateway\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Storage Gateway endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| sts\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for STS endpoint | `bool` | `false` | no |
| sts\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for STS endpoint | `list(string)` | `[]` | no |
| sts\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for STS endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| transfer\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Transfer endpoint | `bool` | `false` | no |
| transfer\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Transfer endpoint | `list(string)` | `[]` | no |
| transfer\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Transfer endpoint. Only a single subnet within an AZ is supported. Ifomitted, private subnets will be used. | `list(string)` | `[]` | no |
| transferserver\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for Transfer Server endpoint | `bool` | `false` | no |
| transferserver\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for Transfer Server endpoint | `list(string)` | `[]` | no |
| transferserver\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for Transfer Server endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| vpc\_endpoint\_tags | Additional tags for the VPC Endpoints | `map(string)` | `{}` | no |
| vpc\_tags | Additional tags for the VPC | `map(string)` | `{}` | no |
| vpn\_gateway\_id | ID of VPN Gateway to attach to the VPC | `string` | `""` | no |
| vpn\_gateway\_tags | Additional tags for the VPN gateway | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| azs | A list of availability zones specified as argument to this module |
| cgw\_ids | List of IDs of Customer Gateway |
| database\_network\_acl\_id | ID of the database network ACL |
| database\_route\_table\_ids | List of IDs of database route tables |
| database\_subnet\_arns | List of ARNs of database subnets |
| database\_subnet\_group | ID of database subnet group |
| database\_subnets | List of IDs of database subnets |
| database\_subnets\_cidr\_blocks | List of cidr\_blocks of database subnets |
| database\_subnets\_ipv6\_cidr\_blocks | List of IPv6 cidr\_blocks of database subnets in an IPv6 enabled VPC |
| default\_network\_acl\_id | The ID of the default network ACL |
| default\_route\_table\_id | The ID of the default route table |
| default\_security\_group\_id | The ID of the security group created by default on VPC creation |
| default\_vpc\_cidr\_block | The CIDR block of the VPC |
| default\_vpc\_default\_network\_acl\_id | The ID of the default network ACL |
| default\_vpc\_default\_route\_table\_id | The ID of the default route table |
| default\_vpc\_default\_security\_group\_id | The ID of the security group created by default on VPC creation |
| default\_vpc\_enable\_dns\_hostnames | Whether or not the VPC has DNS hostname support |
| default\_vpc\_enable\_dns\_support | Whether or not the VPC has DNS support |
| default\_vpc\_id | The ID of the VPC |
| default\_vpc\_instance\_tenancy | Tenancy of instances spin up within VPC |
| default\_vpc\_main\_route\_table\_id | The ID of the main route table associated with this VPC |
| egress\_only\_internet\_gateway\_id | The ID of the egress only Internet Gateway |
| elasticache\_network\_acl\_id | ID of the elasticache network ACL |
| elasticache\_route\_table\_ids | List of IDs of elasticache route tables |
| elasticache\_subnet\_arns | List of ARNs of elasticache subnets |
| elasticache\_subnet\_group | ID of elasticache subnet group |
| elasticache\_subnet\_group\_name | Name of elasticache subnet group |
| elasticache\_subnets | List of IDs of elasticache subnets |
| elasticache\_subnets\_cidr\_blocks | List of cidr\_blocks of elasticache subnets |
| elasticache\_subnets\_ipv6\_cidr\_blocks | List of IPv6 cidr\_blocks of elasticache subnets in an IPv6 enabled VPC |
| igw\_id | The ID of the Internet Gateway |
| intra\_network\_acl\_id | ID of the intra network ACL |
| intra\_route\_table\_association\_ids | IDs of the public route table association |
| intra\_route\_table\_ids | List of IDs of intra route tables |
| intra\_subnet\_arns | List of ARNs of intra subnets |
| intra\_subnets | List of IDs of intra subnets |
| intra\_subnets\_cidr\_blocks | List of cidr\_blocks of intra subnets |
| intra\_subnets\_ipv6\_cidr\_blocks | List of IPv6 cidr\_blocks of intra subnets in an IPv6 enabled VPC |
| name | The name of the VPC specified as argument to this module |
| nat\_ids | List of allocation ID of Elastic IPs created for AWS NAT Gateway |
| nat\_public\_ips | List of public Elastic IPs created for AWS NAT Gateway |
| natgw\_ids | List of NAT Gateway IDs |
| private\_ipv6\_egress\_route\_ids | IDs of the ipv6 egress route. |
| private\_nat\_gateway\_route\_ids | IDs of the private nat gateway route. |
| private\_network\_acl\_id | ID of the private network ACL |
| private\_route\_table\_association\_ids | IDs of the public route table association |
| private\_route\_table\_ids | List of IDs of private route tables |
| private\_subnet\_arns | List of ARNs of private subnets |
| private\_subnets | List of IDs of private subnets |
| private\_subnets\_cidr\_blocks | List of cidr\_blocks of private subnets |
| private\_subnets\_ipv6\_cidr\_blocks | List of IPv6 cidr\_blocks of private subnets in an IPv6 enabled VPC |
| public\_internet\_gateway\_route\_id | ID of the internet gateway route. |
| public\_network\_acl\_id | ID of the public network ACL |
| public\_public\_internet\_gateway\_ipv6\_route\_id | ID of the IPv6 internet gateway route. |
| public\_route\_table\_association\_ids | IDs of the public route table association |
| public\_route\_table\_ids | List of IDs of public route tables |
| public\_subnet\_arns | List of ARNs of public subnets |
| public\_subnets | List of IDs of public subnets |
| public\_subnets\_cidr\_blocks | List of cidr\_blocks of public subnets |
| public\_subnets\_ipv6\_cidr\_blocks | List of IPv6 cidr\_blocks of public subnets in an IPv6 enabled VPC |
| redshift\_network\_acl\_id | ID of the redshift network ACL |
| redshift\_route\_table\_ids | List of IDs of redshift route tables |
| redshift\_subnet\_arns | List of ARNs of redshift subnets |
| redshift\_subnet\_group | ID of redshift subnet group |
| redshift\_subnets | List of IDs of redshift subnets |
| redshift\_subnets\_cidr\_blocks | List of cidr\_blocks of redshift subnets |
| redshift\_subnets\_ipv6\_cidr\_blocks | List of IPv6 cidr\_blocks of redshift subnets in an IPv6 enabled VPC |
| this\_customer\_gateway | Map of Customer Gateway attributes |
| vgw\_id | The ID of the VPN Gateway |
| vpc\_arn | The ARN of the VPC |
| vpc\_cidr\_block | The CIDR block of the VPC |
| vpc\_enable\_dns\_hostnames | Whether or not the VPC has DNS hostname support |
| vpc\_enable\_dns\_support | Whether or not the VPC has DNS support |
| vpc\_endpoint\_apigw\_dns\_entry | The DNS entries for the VPC Endpoint for APIGW. |
| vpc\_endpoint\_apigw\_id | The ID of VPC endpoint for APIGW |
| vpc\_endpoint\_apigw\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for APIGW. |
| vpc\_endpoint\_appmesh\_envoy\_management\_dns\_entry | The DNS entries for the VPC Endpoint for AppMesh. |
| vpc\_endpoint\_appmesh\_envoy\_management\_id | The ID of VPC endpoint for AppMesh |
| vpc\_endpoint\_appmesh\_envoy\_management\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for AppMesh. |
| vpc\_endpoint\_appstream\_dns\_entry | The DNS entries for the VPC Endpoint for AppStream. |
| vpc\_endpoint\_appstream\_id | The ID of VPC endpoint for AppStream |
| vpc\_endpoint\_appstream\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for AppStream. |
| vpc\_endpoint\_athena\_dns\_entry | The DNS entries for the VPC Endpoint for Athena. |
| vpc\_endpoint\_athena\_id | The ID of VPC endpoint for Athena |
| vpc\_endpoint\_athena\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for Athena. |
| vpc\_endpoint\_cloud\_directory\_dns\_entry | The DNS entries for the VPC Endpoint for Cloud Directory. |
| vpc\_endpoint\_cloud\_directory\_id | The ID of VPC endpoint for Cloud Directory |
| vpc\_endpoint\_cloud\_directory\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for Cloud Directory. |
| vpc\_endpoint\_cloudformation\_dns\_entry | The DNS entries for the VPC Endpoint for Cloudformation. |
| vpc\_endpoint\_cloudformation\_id | The ID of VPC endpoint for Cloudformation |
| vpc\_endpoint\_cloudformation\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for Cloudformation. |
| vpc\_endpoint\_cloudtrail\_dns\_entry | The DNS entries for the VPC Endpoint for CloudTrail. |
| vpc\_endpoint\_cloudtrail\_id | The ID of VPC endpoint for CloudTrail |
| vpc\_endpoint\_cloudtrail\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for CloudTrail. |
| vpc\_endpoint\_codebuild\_dns\_entry | The DNS entries for the VPC Endpoint for codebuild. |
| vpc\_endpoint\_codebuild\_id | The ID of VPC endpoint for codebuild |
| vpc\_endpoint\_codebuild\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for codebuild. |
| vpc\_endpoint\_codecommit\_dns\_entry | The DNS entries for the VPC Endpoint for codecommit. |
| vpc\_endpoint\_codecommit\_id | The ID of VPC endpoint for codecommit |
| vpc\_endpoint\_codecommit\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for codecommit. |
| vpc\_endpoint\_codepipeline\_dns\_entry | The DNS entries for the VPC Endpoint for CodePipeline. |
| vpc\_endpoint\_codepipeline\_id | The ID of VPC endpoint for CodePipeline |
| vpc\_endpoint\_codepipeline\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for CodePipeline. |
| vpc\_endpoint\_config\_dns\_entry | The DNS entries for the VPC Endpoint for config. |
| vpc\_endpoint\_config\_id | The ID of VPC endpoint for config |
| vpc\_endpoint\_config\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for config. |
| vpc\_endpoint\_dynamodb\_id | The ID of VPC endpoint for DynamoDB |
| vpc\_endpoint\_dynamodb\_pl\_id | The prefix list for the DynamoDB VPC endpoint. |
| vpc\_endpoint\_ec2\_dns\_entry | The DNS entries for the VPC Endpoint for EC2. |
| vpc\_endpoint\_ec2\_id | The ID of VPC endpoint for EC2 |
| vpc\_endpoint\_ec2\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for EC2 |
| vpc\_endpoint\_ec2messages\_dns\_entry | The DNS entries for the VPC Endpoint for EC2MESSAGES. |
| vpc\_endpoint\_ec2messages\_id | The ID of VPC endpoint for EC2MESSAGES |
| vpc\_endpoint\_ec2messages\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for EC2MESSAGES |
| vpc\_endpoint\_ecr\_api\_dns\_entry | The DNS entries for the VPC Endpoint for ECR API. |
| vpc\_endpoint\_ecr\_api\_id | The ID of VPC endpoint for ECR API |
| vpc\_endpoint\_ecr\_api\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for ECR API. |
| vpc\_endpoint\_ecr\_dkr\_dns\_entry | The DNS entries for the VPC Endpoint for ECR DKR. |
| vpc\_endpoint\_ecr\_dkr\_id | The ID of VPC endpoint for ECR DKR |
| vpc\_endpoint\_ecr\_dkr\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for ECR DKR. |
| vpc\_endpoint\_ecs\_agent\_dns\_entry | The DNS entries for the VPC Endpoint for ECS Agent. |
| vpc\_endpoint\_ecs\_agent\_id | The ID of VPC endpoint for ECS Agent |
| vpc\_endpoint\_ecs\_agent\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for ECS Agent. |
| vpc\_endpoint\_ecs\_dns\_entry | The DNS entries for the VPC Endpoint for ECS. |
| vpc\_endpoint\_ecs\_id | The ID of VPC endpoint for ECS |
| vpc\_endpoint\_ecs\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for ECS. |
| vpc\_endpoint\_ecs\_telemetry\_dns\_entry | The DNS entries for the VPC Endpoint for ECS Telemetry. |
| vpc\_endpoint\_ecs\_telemetry\_id | The ID of VPC endpoint for ECS Telemetry |
| vpc\_endpoint\_ecs\_telemetry\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for ECS Telemetry. |
| vpc\_endpoint\_efs\_dns\_entry | The DNS entries for the VPC Endpoint for EFS. |
| vpc\_endpoint\_efs\_id | The ID of VPC endpoint for EFS |
| vpc\_endpoint\_efs\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for EFS. |
| vpc\_endpoint\_elasticloadbalancing\_dns\_entry | The DNS entries for the VPC Endpoint for Elastic Load Balancing. |
| vpc\_endpoint\_elasticloadbalancing\_id | The ID of VPC endpoint for Elastic Load Balancing |
| vpc\_endpoint\_elasticloadbalancing\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for Elastic Load Balancing. |
| vpc\_endpoint\_events\_dns\_entry | The DNS entries for the VPC Endpoint for CloudWatch Events. |
| vpc\_endpoint\_events\_id | The ID of VPC endpoint for CloudWatch Events |
| vpc\_endpoint\_events\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for CloudWatch Events. |
| vpc\_endpoint\_git\_codecommit\_dns\_entry | The DNS entries for the VPC Endpoint for git\_codecommit. |
| vpc\_endpoint\_git\_codecommit\_id | The ID of VPC endpoint for git\_codecommit |
| vpc\_endpoint\_git\_codecommit\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for git\_codecommit. |
| vpc\_endpoint\_glue\_dns\_entry | The DNS entries for the VPC Endpoint for Glue. |
| vpc\_endpoint\_glue\_id | The ID of VPC endpoint for Glue |
| vpc\_endpoint\_glue\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for Glue. |
| vpc\_endpoint\_kinesis\_firehose\_dns\_entry | The DNS entries for the VPC Endpoint for Kinesis Firehose. |
| vpc\_endpoint\_kinesis\_firehose\_id | The ID of VPC endpoint for Kinesis Firehose |
| vpc\_endpoint\_kinesis\_firehose\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for Kinesis Firehose. |
| vpc\_endpoint\_kinesis\_streams\_dns\_entry | The DNS entries for the VPC Endpoint for Kinesis Streams. |
| vpc\_endpoint\_kinesis\_streams\_id | The ID of VPC endpoint for Kinesis Streams |
| vpc\_endpoint\_kinesis\_streams\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for Kinesis Streams. |
| vpc\_endpoint\_kms\_dns\_entry | The DNS entries for the VPC Endpoint for KMS. |
| vpc\_endpoint\_kms\_id | The ID of VPC endpoint for KMS |
| vpc\_endpoint\_kms\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for KMS. |
| vpc\_endpoint\_logs\_dns\_entry | The DNS entries for the VPC Endpoint for CloudWatch Logs. |
| vpc\_endpoint\_logs\_id | The ID of VPC endpoint for CloudWatch Logs |
| vpc\_endpoint\_logs\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for CloudWatch Logs. |
| vpc\_endpoint\_monitoring\_dns\_entry | The DNS entries for the VPC Endpoint for CloudWatch Monitoring. |
| vpc\_endpoint\_monitoring\_id | The ID of VPC endpoint for CloudWatch Monitoring |
| vpc\_endpoint\_monitoring\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for CloudWatch Monitoring. |
| vpc\_endpoint\_rekognition\_dns\_entry | The DNS entries for the VPC Endpoint for Rekognition. |
| vpc\_endpoint\_rekognition\_id | The ID of VPC endpoint for Rekognition |
| vpc\_endpoint\_rekognition\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for Rekognition. |
| vpc\_endpoint\_s3\_id | The ID of VPC endpoint for S3 |
| vpc\_endpoint\_s3\_pl\_id | The prefix list for the S3 VPC endpoint. |
| vpc\_endpoint\_sagemaker\_api\_dns\_entry | The DNS entries for the VPC Endpoint for SageMaker API. |
| vpc\_endpoint\_sagemaker\_api\_id | The ID of VPC endpoint for SageMaker API |
| vpc\_endpoint\_sagemaker\_api\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for SageMaker API. |
| vpc\_endpoint\_sagemaker\_runtime\_dns\_entry | The DNS entries for the VPC Endpoint for SageMaker Runtime. |
| vpc\_endpoint\_sagemaker\_runtime\_id | The ID of VPC endpoint for SageMaker Runtime |
| vpc\_endpoint\_sagemaker\_runtime\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for SageMaker Runtime. |
| vpc\_endpoint\_secretsmanager\_dns\_entry | The DNS entries for the VPC Endpoint for secretsmanager. |
| vpc\_endpoint\_secretsmanager\_id | The ID of VPC endpoint for secretsmanager |
| vpc\_endpoint\_secretsmanager\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for secretsmanager. |
| vpc\_endpoint\_servicecatalog\_dns\_entry | The DNS entries for the VPC Endpoint for Service Catalog. |
| vpc\_endpoint\_servicecatalog\_id | The ID of VPC endpoint for Service Catalog |
| vpc\_endpoint\_servicecatalog\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for Service Catalog. |
| vpc\_endpoint\_sns\_dns\_entry | The DNS entries for the VPC Endpoint for SNS. |
| vpc\_endpoint\_sns\_id | The ID of VPC endpoint for SNS |
| vpc\_endpoint\_sns\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for SNS. |
| vpc\_endpoint\_sqs\_dns\_entry | The DNS entries for the VPC Endpoint for SQS. |
| vpc\_endpoint\_sqs\_id | The ID of VPC endpoint for SQS |
| vpc\_endpoint\_sqs\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for SQS. |
| vpc\_endpoint\_ssm\_dns\_entry | The DNS entries for the VPC Endpoint for SSM. |
| vpc\_endpoint\_ssm\_id | The ID of VPC endpoint for SSM |
| vpc\_endpoint\_ssm\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for SSM. |
| vpc\_endpoint\_ssmmessages\_dns\_entry | The DNS entries for the VPC Endpoint for SSMMESSAGES. |
| vpc\_endpoint\_ssmmessages\_id | The ID of VPC endpoint for SSMMESSAGES |
| vpc\_endpoint\_ssmmessages\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for SSMMESSAGES. |
| vpc\_endpoint\_storagegateway\_dns\_entry | The DNS entries for the VPC Endpoint for Storage Gateway. |
| vpc\_endpoint\_storagegateway\_id | The ID of VPC endpoint for Storage Gateway |
| vpc\_endpoint\_storagegateway\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for Storage Gateway. |
| vpc\_endpoint\_sts\_dns\_entry | The DNS entries for the VPC Endpoint for STS. |
| vpc\_endpoint\_sts\_id | The ID of VPC endpoint for STS |
| vpc\_endpoint\_sts\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for STS. |
| vpc\_endpoint\_transfer\_dns\_entry | The DNS entries for the VPC Endpoint for Transfer. |
| vpc\_endpoint\_transfer\_id | The ID of VPC endpoint for Transfer |
| vpc\_endpoint\_transfer\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for Transfer. |
| vpc\_endpoint\_transferserver\_dns\_entry | The DNS entries for the VPC Endpoint for transferserver. |
| vpc\_endpoint\_transferserver\_id | The ID of VPC endpoint for transferserver |
| vpc\_endpoint\_transferserver\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for transferserver |
| vpc\_id | The ID of the VPC |
| vpc\_instance\_tenancy | Tenancy of instances spin up within VPC |
| vpc\_ipv6\_association\_id | The association ID for the IPv6 CIDR block |
| vpc\_ipv6\_cidr\_block | The IPv6 CIDR block |
| vpc\_main\_route\_table\_id | The ID of the main route table associated with this VPC |
| vpc\_secondary\_cidr\_blocks | List of secondary CIDR blocks of the VPC |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
