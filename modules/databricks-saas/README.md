# databricks-saas

## Diagram

![diagram](diagram.png)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_common"></a> [common](#module\_common) | ../internal/common | n/a |
| <a name="module_iam"></a> [iam](#module\_iam) | ../internal/databricks/iam | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cross_account_assume_role_allowed_ids"></a> [cross\_account\_assume\_role\_allowed\_ids](#input\_cross\_account\_assume\_role\_allowed\_ids) | A list of AWS account IDs allowed to assume the cross-account role(s). This should be an<br>AWS account ID that is provided by your Tecton rep. | `list(string)` | n/a | yes |
| <a name="input_databricks_workspace"></a> [databricks\_workspace](#input\_databricks\_workspace) | The Databricks workspace name not including the full url and not including `cloud.databricks.com`.<br>E.g. `my-workspace.cloud.databricks.com` -> `my-workspace`. | `string` | n/a | yes |
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | A unique deployment name. | `string` | n/a | yes |
| <a name="input_spark_role_name"></a> [spark\_role\_name](#input\_spark\_role\_name) | The name of the spark role used for Databricks to attach policies to. | `string` | n/a | yes |
| <a name="input_cross_account_external_id"></a> [cross\_account\_external\_id](#input\_cross\_account\_external\_id) | A random ID to be associated with the cross-account assume role. This will need to be<br>communicated to your Tecton technical support rep. By default a random ID will be generated if none<br>provided. | `string` | `null` | no |
| <a name="input_enable_elasticache"></a> [enable\_elasticache](#input\_enable\_elasticache) | Toggle enabling resources supporting the ElastiCache. | `bool` | `false` | no |
| <a name="input_enable_spot_service_linked_role"></a> [enable\_spot\_service\_linked\_role](#input\_enable\_spot\_service\_linked\_role) | Toggle enabling the spot service linked role. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cross_account_external_id"></a> [cross\_account\_external\_id](#output\_cross\_account\_external\_id) | The external ID to be associated with the cross-account assume role. |
| <a name="output_cross_account_role_arn"></a> [cross\_account\_role\_arn](#output\_cross\_account\_role\_arn) | The ARN of the cross-account IAM role. |
| <a name="output_cross_account_role_name"></a> [cross\_account\_role\_name](#output\_cross\_account\_role\_name) | The name of the cross-account IAM role. |
| <a name="output_databricks_workspace"></a> [databricks\_workspace](#output\_databricks\_workspace) | The Databricks workspace name. |
| <a name="output_deployment_name"></a> [deployment\_name](#output\_deployment\_name) | The Tecton deployment name. |
| <a name="output_region"></a> [region](#output\_region) | The AWS region. |
| <a name="output_s3_bucket"></a> [s3\_bucket](#output\_s3\_bucket) | The Tecton S3 bucket. |
| <a name="output_spark_role_arn"></a> [spark\_role\_arn](#output\_spark\_role\_arn) | The ARN of the Spark IAM role. |
| <a name="output_spark_role_name"></a> [spark\_role\_name](#output\_spark\_role\_name) | The name of the Spark IAM role. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
