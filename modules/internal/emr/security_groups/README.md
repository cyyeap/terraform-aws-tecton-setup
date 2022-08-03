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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.24.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_deployment_name"></a> [deployment\_name](#module\_deployment\_name) | ../../deployment_name | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.cluster_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.service_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.security_group_full_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.security_group_self_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.security_group_service_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.service_security_group_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.service_security_group_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | A unique deployment name. | `string` | n/a | yes |
| <a name="input_cluster_security_group_id"></a> [cluster\_security\_group\_id](#input\_cluster\_security\_group\_id) | Optionally provide a security group to place EMR cluster resources in. It is<br>recommended to use the defaults (module will create the security group). | `string` | `null` | no |
| <a name="input_enable_security_group_rules"></a> [enable\_security\_group\_rules](#input\_enable\_security\_group\_rules) | Disable the creation of security group rules. It is recommended<br>to use the defaults (module will create the security group rules associated<br>with the appropriate security group). | `bool` | `true` | no |
| <a name="input_service_security_group_id"></a> [service\_security\_group\_id](#input\_service\_security\_group\_id) | Optionally provide a security group to place EMR service resources in. It is<br>recommended to use the defaults (module will create the security group). | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of a pre-existing VPC to deploy the networking resources to.<br>By default (recommended) one will be created if none specified. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ids"></a> [ids](#output\_ids) | A map of the security group IDs. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
