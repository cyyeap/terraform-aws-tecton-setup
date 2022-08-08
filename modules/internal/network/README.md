# network

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.25.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_deployment_name"></a> [deployment\_name](#module\_deployment\_name) | ../deployment_name | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private_to_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.tecton](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_route_table_association.dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_ipv4_cidr_block_association.vpc_cidr_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | A unique deployment name. | `string` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The CIDR block for the private and public subnets for this module to create. The<br>smallest acceptable prefix is /18. Only half of the CIDR will be used to reserve space for future<br>growth. | `string` | n/a | yes |
| <a name="input_availability_zone_count"></a> [availability\_zone\_count](#input\_availability\_zone\_count) | The number of availability zones to deploy in to. If none specified (default), 3 will be<br>used, unless region only has 2 available AZs. Please set this to 3 unless the region being deployed<br>to only has 2 AZs. | `number` | `0` | no |
| <a name="input_dynamodb_vpc_endpoint_id"></a> [dynamodb\_vpc\_endpoint\_id](#input\_dynamodb\_vpc\_endpoint\_id) | Specify the DynamoDB VPC endpoint to route traffic to. If not specified and<br>`enable_dynamodb_vpc_endpoint` is true one will be created. | `string` | `null` | no |
| <a name="input_enable_dynamodb_vpc_endpoint"></a> [enable\_dynamodb\_vpc\_endpoint](#input\_enable\_dynamodb\_vpc\_endpoint) | Toggle enabling the creation of the DynamoDB VPC endpoint. | `bool` | `true` | no |
| <a name="input_enable_public_subnets"></a> [enable\_public\_subnets](#input\_enable\_public\_subnets) | Toggle enabling the creation of the public subnets. | `bool` | `true` | no |
| <a name="input_enable_s3_vpc_endpoint"></a> [enable\_s3\_vpc\_endpoint](#input\_enable\_s3\_vpc\_endpoint) | Toggle enabling the creation of the s3 VPC endpoint. | `bool` | `true` | no |
| <a name="input_enable_vpc_cidr_block_association"></a> [enable\_vpc\_cidr\_block\_association](#input\_enable\_vpc\_cidr\_block\_association) | Only used when `vpc_id` is specified. Toggle enabling the<br>`aws_vpc_ipv4_cidr_block_association` between the given `vpc_cidr_block` and the VPC specified by<br>`vpc_id`. Should only be disabled if the VPC specified VPC cidr exists and is already associated<br>with the specified VPC. | `bool` | `true` | no |
| <a name="input_nat_gateways_by_az"></a> [nat\_gateways\_by\_az](#input\_nat\_gateways\_by\_az) | Specify existing NAT gateways to be routed to. Input as a mapping of<br>`availability_zone : nat_gateway_id` (example:<br>`{"us-west-2a"= "nat_gateway_a","us-west-2b"= "nat_gateway_b","us-west-2c"= "nat_gateway_c"}`).<br>If none specified, one NAT gateway will be created per availability zone." | `map(string)` | `null` | no |
| <a name="input_s3_vpc_endpoint_id"></a> [s3\_vpc\_endpoint\_id](#input\_s3\_vpc\_endpoint\_id) | Specify the S3 VPC endpoint to route traffic to. If not specified and<br>`enable_s3_vpc_endpoint` is true one will be created. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of a pre-existing VPC to deploy the networking resources to. By default<br>(recommended) one will be created if none specified. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zone_count"></a> [availability\_zone\_count](#output\_availability\_zone\_count) | The number of availability zones in-use. |
| <a name="output_dynamodb_vpc_endpoint_id"></a> [dynamodb\_vpc\_endpoint\_id](#output\_dynamodb\_vpc\_endpoint\_id) | The DynamoDB VPC endpoint ID (if enabled). |
| <a name="output_nat_gateway_public_ips"></a> [nat\_gateway\_public\_ips](#output\_nat\_gateway\_public\_ips) | The IDs of the NAT gateway public IPs. |
| <a name="output_nat_gateways_by_az"></a> [nat\_gateways\_by\_az](#output\_nat\_gateways\_by\_az) | A map of nat gateways by their respective availability zone. (`{availability_zone_name: nat_gateway_id}`) |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | The IDs of the private subnets. |
| <a name="output_private_subnet_route_table_ids"></a> [private\_subnet\_route\_table\_ids](#output\_private\_subnet\_route\_table\_ids) | The IDs of the private subnet route tables. |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | The IDs of the public subnets. |
| <a name="output_public_subnet_route_table_ids"></a> [public\_subnet\_route\_table\_ids](#output\_public\_subnet\_route\_table\_ids) | The IDs of the public subnet route tables. |
| <a name="output_s3_vpc_endpoint_id"></a> [s3\_vpc\_endpoint\_id](#output\_s3\_vpc\_endpoint\_id) | The S3 VPC endpoint ID (if enabled). |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The VPC CIDR block. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
