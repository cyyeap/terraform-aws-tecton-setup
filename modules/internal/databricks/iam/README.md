# iam

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3 |
| <a name="provider_aws.databricks"></a> [aws.databricks](#provider\_aws.databricks) | >= 3 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_deployment_name"></a> [deployment\_name](#module\_deployment\_name) | ../../deployment_name | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cross_account_databricks_tecton_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cross_account_from_databricks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.cross_account_databricks_tecton_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cross_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cross_account_databricks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [random_id.external_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.databricks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cross_account_databricks_tecton_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_role.spark_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | A unique deployment name. | `string` | n/a | yes |
| <a name="input_deployment_type"></a> [deployment\_type](#input\_deployment\_type) | The type of Tecton cluster deployment. (to be provided by Tecton rep) | `string` | n/a | yes |
| <a name="input_spark_role_name"></a> [spark\_role\_name](#input\_spark\_role\_name) | The name of the spark role used for Databricks to attach policies to. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cross_account_databricks_tecton_access_role_arn"></a> [cross\_account\_databricks\_tecton\_access\_role\_arn](#output\_cross\_account\_databricks\_tecton\_access\_role\_arn) | The ARN of the AWS IAM role used to grant Databricks access to Tecton resources. |
| <a name="output_cross_account_databricks_tecton_access_role_external_id"></a> [cross\_account\_databricks\_tecton\_access\_role\_external\_id](#output\_cross\_account\_databricks\_tecton\_access\_role\_external\_id) | The external-id required when assuming the AWS IAM role used to grant Databricks access to Tecton resources. |
| <a name="output_cross_account_databricks_tecton_access_role_name"></a> [cross\_account\_databricks\_tecton\_access\_role\_name](#output\_cross\_account\_databricks\_tecton\_access\_role\_name) | The name of the AWS IAM role used to grant Databricks access to Tecton resources. |
| <a name="output_spark_role_arn"></a> [spark\_role\_arn](#output\_spark\_role\_arn) | The ARN of the spark role. |
| <a name="output_spark_role_name"></a> [spark\_role\_name](#output\_spark\_role\_name) | The name of the spark role. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
