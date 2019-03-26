# Terraform VPC module

This module is a copy of the [public Terraform VPC module](https://github.com/terraform-aws-modules/terraform-aws-vpc/).
It brings:
 
- Another extra private subnet.
- AZs prefix are numbers not AZ names.
- Counts in outputs for Terraform 0.11.X counting issues.

This module is not to be deployed directly.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| amazon\_side\_asn | The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the virtual private gateway is created with the current default Amazon ASN. | string | `"64512"` | no |
| apigw\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for API GW endpoint | string | `"false"` | no |
| apigw\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for API GW  endpoint | list | `[]` | no |
| apigw\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for API GW endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | list | `[]` | no |
| assign\_generated\_ipv6\_cidr\_block | Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block | string | `"false"` | no |
| azs | A list of availability zones in the region | list | `[]` | no |
| cidr | The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden | string | `"0.0.0.0/0"` | no |
| create\_database\_internet\_gateway\_route | Controls if an internet gateway route for public database access should be created | string | `"false"` | no |
| create\_database\_nat\_gateway\_route | Controls if a nat gateway route should be created to give internet access to the database subnets | string | `"false"` | no |
| create\_database\_subnet\_group | Controls if database subnet group should be created | string | `"true"` | no |
| create\_database\_subnet\_route\_table | Controls if separate route table for database should be created | string | `"false"` | no |
| create\_elasticache\_subnet\_group | Controls if elasticache subnet group should be created | string | `"true"` | no |
| create\_elasticache\_subnet\_route\_table | Controls if separate route table for elasticache should be created | string | `"false"` | no |
| create\_redshift\_subnet\_group | Controls if redshift subnet group should be created | string | `"true"` | no |
| create\_redshift\_subnet\_route\_table | Controls if separate route table for redshift should be created | string | `"false"` | no |
| create\_vpc | Controls if VPC should be created (it affects almost all resources) | string | `"true"` | no |
| database\_acl\_tags | Additional tags for the database subnets network ACL | map | `{}` | no |
| database\_dedicated\_network\_acl | Whether to use dedicated network ACL (not default) and custom rules for database subnets | string | `"false"` | no |
| database\_inbound\_acl\_rules | Database subnets inbound network ACL rules | list | `[ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]` | no |
| database\_outbound\_acl\_rules | Database subnets outbound network ACL rules | list | `[ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]` | no |
| database\_route\_table\_tags | Additional tags for the database route tables | map | `{}` | no |
| database\_subnet\_group\_tags | Additional tags for the database subnet group | map | `{}` | no |
| database\_subnet\_suffix | Suffix to append to database subnets name | string | `"db"` | no |
| database\_subnet\_tags | Additional tags for the database subnets | map | `{}` | no |
| database\_subnets | A list of database subnets | list | `[]` | no |
| default\_network\_acl\_egress | List of maps of egress rules to set on the Default Network ACL | list | `[ { "action": "allow", "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_no": 100, "to_port": 0 }, { "action": "allow", "from_port": 0, "ipv6_cidr_block": "::/0", "protocol": "-1", "rule_no": 101, "to_port": 0 } ]` | no |
| default\_network\_acl\_ingress | List of maps of ingress rules to set on the Default Network ACL | list | `[ { "action": "allow", "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_no": 100, "to_port": 0 }, { "action": "allow", "from_port": 0, "ipv6_cidr_block": "::/0", "protocol": "-1", "rule_no": 101, "to_port": 0 } ]` | no |
| default\_network\_acl\_name | Name to be used on the Default Network ACL | string | `""` | no |
| default\_network\_acl\_tags | Additional tags for the Default Network ACL | map | `{}` | no |
| default\_vpc\_enable\_classiclink | Should be true to enable ClassicLink in the Default VPC | string | `"false"` | no |
| default\_vpc\_enable\_dns\_hostnames | Should be true to enable DNS hostnames in the Default VPC | string | `"false"` | no |
| default\_vpc\_enable\_dns\_support | Should be true to enable DNS support in the Default VPC | string | `"true"` | no |
| default\_vpc\_name | Name to be used on the Default VPC | string | `""` | no |
| default\_vpc\_tags | Additional tags for the Default VPC | map | `{}` | no |
| dhcp\_options\_domain\_name | Specifies DNS name for DHCP options set | string | `""` | no |
| dhcp\_options\_domain\_name\_servers | Specify a list of DNS server addresses for DHCP options set, default to AWS provided | list | `[ "AmazonProvidedDNS" ]` | no |
| dhcp\_options\_netbios\_name\_servers | Specify a list of netbios servers for DHCP options set | list | `[]` | no |
| dhcp\_options\_netbios\_node\_type | Specify netbios node_type for DHCP options set | string | `""` | no |
| dhcp\_options\_ntp\_servers | Specify a list of NTP servers for DHCP options set | list | `[]` | no |
| dhcp\_options\_tags | Additional tags for the DHCP option set | map | `{}` | no |
| ec2\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for EC2 endpoint | string | `"false"` | no |
| ec2\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for EC2 endpoint | list | `[]` | no |
| ec2\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for EC2 endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | list | `[]` | no |
| ec2messages\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for EC2MESSAGES endpoint | string | `"false"` | no |
| ec2messages\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for EC2MESSAGES endpoint | list | `[]` | no |
| ec2messages\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for EC2MESSAGES endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | list | `[]` | no |
| ecr\_api\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for ECR API endpoint | string | `"false"` | no |
| ecr\_api\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for ECR API endpoint | list | `[]` | no |
| ecr\_api\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for ECR api endpoint. If omitted, private subnets will be used. | list | `[]` | no |
| ecr\_dkr\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for ECR DKR endpoint | string | `"false"` | no |
| ecr\_dkr\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for ECR DKR endpoint | list | `[]` | no |
| ecr\_dkr\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for ECR dkr endpoint. If omitted, private subnets will be used. | list | `[]` | no |
| elasticache\_acl\_tags | Additional tags for the elasticache subnets network ACL | map | `{}` | no |
| elasticache\_dedicated\_network\_acl | Whether to use dedicated network ACL (not default) and custom rules for elasticache subnets | string | `"false"` | no |
| elasticache\_inbound\_acl\_rules | Elasticache subnets inbound network ACL rules | list | `[ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]` | no |
| elasticache\_outbound\_acl\_rules | Elasticache subnets outbound network ACL rules | list | `[ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]` | no |
| elasticache\_route\_table\_tags | Additional tags for the elasticache route tables | map | `{}` | no |
| elasticache\_subnet\_suffix | Suffix to append to elasticache subnets name | string | `"elasticache"` | no |
| elasticache\_subnet\_tags | Additional tags for the elasticache subnets | map | `{}` | no |
| elasticache\_subnets | A list of elasticache subnets | list | `[]` | no |
| enable\_apigw\_endpoint | Should be true if you want to provision an api gateway endpoint to the VPC | string | `"false"` | no |
| enable\_dhcp\_options | Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type | string | `"false"` | no |
| enable\_dns\_hostnames | Should be true to enable DNS hostnames in the VPC | string | `"false"` | no |
| enable\_dns\_support | Should be true to enable DNS support in the VPC | string | `"true"` | no |
| enable\_dynamodb\_endpoint | Should be true if you want to provision a DynamoDB endpoint to the VPC | string | `"false"` | no |
| enable\_ec2\_endpoint | Should be true if you want to provision an EC2 endpoint to the VPC | string | `"false"` | no |
| enable\_ec2messages\_endpoint | Should be true if you want to provision an EC2MESSAGES endpoint to the VPC | string | `"false"` | no |
| enable\_ecr\_api\_endpoint | Should be true if you want to provision an ecr api endpoint to the VPC | string | `"false"` | no |
| enable\_ecr\_dkr\_endpoint | Should be true if you want to provision an ecr dkr endpoint to the VPC | string | `"false"` | no |
| enable\_nat\_gateway | Should be true if you want to provision NAT Gateways for each of your private networks | string | `"false"` | no |
| enable\_public\_redshift | Controls if redshift should have public routing table | string | `"false"` | no |
| enable\_s3\_endpoint | Should be true if you want to provision an S3 endpoint to the VPC | string | `"false"` | no |
| enable\_ssm\_endpoint | Should be true if you want to provision an SSM endpoint to the VPC | string | `"false"` | no |
| enable\_ssmmessages\_endpoint | Should be true if you want to provision a SSMMESSAGES endpoint to the VPC | string | `"false"` | no |
| enable\_vpn\_gateway | Should be true if you want to create a new VPN Gateway resource and attach it to the VPC | string | `"false"` | no |
| external\_nat\_ip\_ids | List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse_nat_ips) | list | `[]` | no |
| igw\_tags | Additional tags for the internet gateway | map | `{}` | no |
| instance\_tenancy | A tenancy option for instances launched into the VPC | string | `"default"` | no |
| intra\_acl\_tags | Additional tags for the intra subnets network ACL | map | `{}` | no |
| intra\_dedicated\_network\_acl | Whether to use dedicated network ACL (not default) and custom rules for intra subnets | string | `"false"` | no |
| intra\_inbound\_acl\_rules | Intra subnets inbound network ACLs | list | `[ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]` | no |
| intra\_outbound\_acl\_rules | Intra subnets outbound network ACLs | list | `[ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]` | no |
| intra\_route\_table\_tags | Additional tags for the intra route tables | map | `{}` | no |
| intra\_subnet\_suffix | Suffix to append to intra subnets name | string | `"intra"` | no |
| intra\_subnet\_tags | Additional tags for the intra subnets | map | `{}` | no |
| intra\_subnets | A list of intra subnets | list | `[]` | no |
| manage\_default\_network\_acl | Should be true to adopt and manage Default Network ACL | string | `"false"` | no |
| manage\_default\_vpc | Should be true to adopt and manage Default VPC | string | `"false"` | no |
| map\_public\_ip\_on\_launch | Should be false if you do not want to auto-assign public IP on launch | string | `"true"` | no |
| name | Name to be used on all the resources as identifier | string | `""` | no |
| nat\_eip\_tags | Additional tags for the NAT EIP | map | `{}` | no |
| nat\_gateway\_tags | Additional tags for the NAT gateways | map | `{}` | no |
| one\_nat\_gateway\_per\_az | Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`. | string | `"false"` | no |
| private\_acl\_tags | Additional tags for the private subnets network ACL | map | `{}` | no |
| private\_dedicated\_network\_acl | Whether to use dedicated network ACL (not default) and custom rules for private subnets | string | `"false"` | no |
| private\_extra\_acl\_tags | Additional tags for the private extra subnets network ACL | map | `{}` | no |
| private\_extra\_dedicated\_network\_acl | Whether to use dedicated network ACL (not default) and custom rules for private extra subnets | string | `"false"` | no |
| private\_extra\_inbound\_acl\_rules | Private extra subnets inbound network ACLs | list | `[ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]` | no |
| private\_extra\_outbound\_acl\_rules | Private extra subnets outbound network ACLs | list | `[ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]` | no |
| private\_extra\_route\_table\_tags | Additional tags for the private extra route tables | map | `{}` | no |
| private\_extra\_subnet\_suffix | Suffix to append to private extra subnets name | string | `"private-extra"` | no |
| private\_extra\_subnet\_tags | Additional tags for the private extra subnets | map | `{}` | no |
| private\_extra\_subnets | A list of private extra subnets inside the VPC | list | `[]` | no |
| private\_inbound\_acl\_rules | Private subnets inbound network ACLs | list | `[ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]` | no |
| private\_outbound\_acl\_rules | Private subnets outbound network ACLs | list | `[ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]` | no |
| private\_route\_table\_tags | Additional tags for the private route tables | map | `{}` | no |
| private\_subnet\_suffix | Suffix to append to private subnets name | string | `"private"` | no |
| private\_subnet\_tags | Additional tags for the private subnets | map | `{}` | no |
| private\_subnets | A list of private subnets inside the VPC | list | `[]` | no |
| propagate\_private\_route\_tables\_vgw | Should be true if you want route table propagation | string | `"false"` | no |
| propagate\_public\_route\_tables\_vgw | Should be true if you want route table propagation | string | `"false"` | no |
| public\_acl\_tags | Additional tags for the public subnets network ACL | map | `{}` | no |
| public\_dedicated\_network\_acl | Whether to use dedicated network ACL (not default) and custom rules for public subnets | string | `"false"` | no |
| public\_inbound\_acl\_rules | Public subnets inbound network ACLs | list | `[ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]` | no |
| public\_outbound\_acl\_rules | Public subnets outbound network ACLs | list | `[ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]` | no |
| public\_route\_table\_tags | Additional tags for the public route tables | map | `{}` | no |
| public\_subnet\_suffix | Suffix to append to public subnets name | string | `"public"` | no |
| public\_subnet\_tags | Additional tags for the public subnets | map | `{}` | no |
| public\_subnets | A list of public subnets inside the VPC | list | `[]` | no |
| redshift\_acl\_tags | Additional tags for the redshift subnets network ACL | map | `{}` | no |
| redshift\_dedicated\_network\_acl | Whether to use dedicated network ACL (not default) and custom rules for redshift subnets | string | `"false"` | no |
| redshift\_inbound\_acl\_rules | Redshift subnets inbound network ACL rules | list | `[ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]` | no |
| redshift\_outbound\_acl\_rules | Redshift subnets outbound network ACL rules | list | `[ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]` | no |
| redshift\_route\_table\_tags | Additional tags for the redshift route tables | map | `{}` | no |
| redshift\_subnet\_group\_tags | Additional tags for the redshift subnet group | map | `{}` | no |
| redshift\_subnet\_suffix | Suffix to append to redshift subnets name | string | `"redshift"` | no |
| redshift\_subnet\_tags | Additional tags for the redshift subnets | map | `{}` | no |
| redshift\_subnets | A list of redshift subnets | list | `[]` | no |
| reuse\_nat\_ips | Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids' variable | string | `"false"` | no |
| secondary\_cidr\_blocks | List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool | list | `[]` | no |
| single\_nat\_gateway | Should be true if you want to provision a single shared NAT Gateway across all of your private networks | string | `"false"` | no |
| ssm\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for SSM endpoint | string | `"false"` | no |
| ssm\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for SSM endpoint | list | `[]` | no |
| ssm\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for SSM endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | list | `[]` | no |
| ssmmessages\_endpoint\_private\_dns\_enabled | Whether or not to associate a private hosted zone with the specified VPC for SSMMESSAGES endpoint | string | `"false"` | no |
| ssmmessages\_endpoint\_security\_group\_ids | The ID of one or more security groups to associate with the network interface for SSMMESSAGES endpoint | list | `[]` | no |
| ssmmessages\_endpoint\_subnet\_ids | The ID of one or more subnets in which to create a network interface for SSMMESSAGES endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | list | `[]` | no |
| tags | A map of tags to add to all resources | map | `{}` | no |
| vpc\_tags | Additional tags for the VPC | map | `{}` | no |
| vpn\_gateway\_id | ID of VPN Gateway to attach to the VPC | string | `""` | no |
| vpn\_gateway\_tags | Additional tags for the VPN gateway | map | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| database\_network\_acl\_id | ID of the database network ACL |
| database\_route\_table\_count | Count of database route tables |
| database\_route\_table\_ids | List of IDs of database route tables |
| database\_subnet\_group | ID of database subnet group |
| database\_subnets | List of IDs of database subnets |
| database\_subnets\_cidr\_blocks | List of cidr_blocks of database subnets |
| database\_subnets\_count | Count of database subnets |
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
| elasticache\_network\_acl\_id | ID of the elasticache network ACL |
| elasticache\_route\_table\_count | Count of elasticache route tables |
| elasticache\_route\_table\_ids | List of IDs of elasticache route tables |
| elasticache\_subnet\_group | ID of elasticache subnet group |
| elasticache\_subnet\_group\_name | Name of elasticache subnet group |
| elasticache\_subnets | List of IDs of elasticache subnets |
| elasticache\_subnets\_cidr\_blocks | List of cidr_blocks of elasticache subnets |
| elasticache\_subnets\_count | Count of elasticache subnets |
| igw\_id | The ID of the Internet Gateway |
| intra\_network\_acl\_id | ID of the intra network ACL |
| intra\_route\_table\_count | Count of public route tables |
| intra\_route\_table\_ids | List of IDs of intra route tables |
| intra\_subnets | List of IDs of intra subnets |
| intra\_subnets\_cidr\_blocks | List of cidr_blocks of intra subnets |
| intra\_subnets\_count | Count of intra subnets |
| nat\_gateway\_count | Count of NAT Gateways |
| nat\_ids | List of allocation ID of Elastic IPs created for AWS NAT Gateway |
| nat\_public\_ips | List of public Elastic IPs created for AWS NAT Gateway |
| natgw\_ids | List of NAT Gateway IDs |
| private\_extra\_network\_acl\_id | ID of the private extra network ACL |
| private\_extra\_route\_table\_count | Count of private extra route tables |
| private\_extra\_route\_table\_ids | List of IDs of private extra route tables |
| private\_extra\_subnets | List of IDs of private extra subnets |
| private\_extra\_subnets\_cidr\_blocks | List of cidr_blocks of private extra subnets |
| private\_extra\_subnets\_count | Count of private extra subnets |
| private\_network\_acl\_id | ID of the private network ACL |
| private\_route\_table\_count | Count of private route tables |
| private\_route\_table\_ids | List of IDs of private route tables |
| private\_subnets | List of IDs of private subnets |
| private\_subnets\_cidr\_blocks | List of cidr_blocks of private subnets |
| private\_subnets\_count | Count of private subnets |
| public\_network\_acl\_id | ID of the public network ACL |
| public\_route\_table\_count | Count of public route tables |
| public\_route\_table\_ids | List of IDs of public route tables |
| public\_subnets | List of IDs of public subnets |
| public\_subnets\_cidr\_blocks | List of cidr_blocks of public subnets |
| public\_subnets\_count | Count of public subnets |
| redshift\_network\_acl\_id | ID of the redshift network ACL |
| redshift\_route\_table\_count | Count of redshift route tables |
| redshift\_route\_table\_ids | List of IDs of redshift route tables |
| redshift\_subnet\_group | ID of redshift subnet group |
| redshift\_subnets | List of IDs of redshift subnets |
| redshift\_subnets\_cidr\_blocks | List of cidr_blocks of redshift subnets |
| redshift\_subnets\_count | Count of redshift subnets |
| total\_subnets\_count | Count of all the subnets |
| vgw\_id | The ID of the VPN Gateway |
| vpc\_cidr\_block | The CIDR block of the VPC |
| vpc\_enable\_dns\_hostnames | Whether or not the VPC has DNS hostname support |
| vpc\_enable\_dns\_support | Whether or not the VPC has DNS support |
| vpc\_endpoint\_dynamodb\_id | The ID of VPC endpoint for DynamoDB |
| vpc\_endpoint\_dynamodb\_pl\_id | The prefix list for the DynamoDB VPC endpoint. |
| vpc\_endpoint\_ec2\_dns\_entry | The DNS entries for the VPC Endpoint for EC2. |
| vpc\_endpoint\_ec2\_id | The ID of VPC endpoint for EC2 |
| vpc\_endpoint\_ec2\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for EC2 |
| vpc\_endpoint\_ec2messages\_dns\_entry | The DNS entries for the VPC Endpoint for EC2MESSAGES. |
| vpc\_endpoint\_ec2messages\_id | The ID of VPC endpoint for EC2MESSAGES |
| vpc\_endpoint\_ec2messages\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for EC2MESSAGES |
| vpc\_endpoint\_s3\_id | The ID of VPC endpoint for S3 |
| vpc\_endpoint\_s3\_pl\_id | The prefix list for the S3 VPC endpoint. |
| vpc\_endpoint\_ssm\_dns\_entry | The DNS entries for the VPC Endpoint for SSM. |
| vpc\_endpoint\_ssm\_id | The ID of VPC endpoint for SSM |
| vpc\_endpoint\_ssm\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for SSM. |
| vpc\_endpoint\_ssmmessages\_dns\_entry | The DNS entries for the VPC Endpoint for SSMMESSAGES. |
| vpc\_endpoint\_ssmmessages\_id | The ID of VPC endpoint for SSMMESSAGES |
| vpc\_endpoint\_ssmmessages\_network\_interface\_ids | One or more network interfaces for the VPC Endpoint for SSMMESSAGES. |
| vpc\_id | The ID of the VPC |
| vpc\_instance\_tenancy | Tenancy of instances spin up within VPC |
| vpc\_main\_route\_table\_id | The ID of the main route table associated with this VPC |
| vpc\_secondary\_cidr\_blocks | List of secondary CIDR blocks of the VPC |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
