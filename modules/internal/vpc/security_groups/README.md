# security_groups

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_deployment_name"></a> [deployment\_name](#module\_deployment\_name) | ../../deployment_name | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.control](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ingress_vpc_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.cluster_ingress_node_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_vpc_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.lb_to_cluster_ingress_port](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.node_ingress_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.node_ingress_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.public_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | A unique deployment name. | `string` | n/a | yes |
| <a name="input_enable_ingress_vpc_endpoint"></a> [enable\_ingress\_vpc\_endpoint](#input\_enable\_ingress\_vpc\_endpoint) | Toggle enabling resources supporting the EKS Ingress VPC Endpoint for in-VPC<br>communication. | `bool` | `true` | no |
| <a name="input_ingress_allowed_cidr_blocks"></a> [ingress\_allowed\_cidr\_blocks](#input\_ingress\_allowed\_cidr\_blocks) | CIDR blocks that should be able to access the Tecton cluster. Defaults to `0.0.0.0/0` if<br>none specified. | `list(string)` | `[]` | no |
| <a name="input_ingress_load_balancer_public"></a> [ingress\_load\_balancer\_public](#input\_ingress\_load\_balancer\_public) | Toggle whether or not the Tecton cluster ingress should be accessible by the public<br>internet and have a public IP address. | `bool` | `true` | no |
| <a name="input_nat_gateway_ips"></a> [nat\_gateway\_ips](#input\_nat\_gateway\_ips) | Public IP addresses of the NAT gateways from the public subnet. Must be set if<br>`allowed_CIDR_blocks` is `true` and `eks_ingress_load_balancer_public` is `true`. | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of a pre-existing VPC to deploy the networking resources to. By default<br>(recommended) one will be created if none specified. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ids"></a> [ids](#output\_ids) | A map of the security group IDs. |
| <a name="output_ingress_vpc_endpoint_id"></a> [ingress\_vpc\_endpoint\_id](#output\_ingress\_vpc\_endpoint\_id) | If deployment\_type is vpc, the ID of the ingress VPC endpoint. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
