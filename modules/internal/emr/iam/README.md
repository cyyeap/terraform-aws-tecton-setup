# iam

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
| <a name="module_deployment_name"></a> [deployment\_name](#module\_deployment\_name) | ../../deployment_name | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.spark](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.emr_spark_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.master_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.spark_access_emr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.tecton_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.master_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.spark_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cross_account_databricks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.emr_master_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.emr_spark_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.emr_ssm_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.spark_access_emr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.master_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.spark_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | A unique deployment name. | `string` | n/a | yes |
| <a name="input_deployment_type"></a> [deployment\_type](#input\_deployment\_type) | The type of Tecton cluster deployment. (to be provided by Tecton rep) | `string` | n/a | yes |
| <a name="input_spark_access_role"></a> [spark\_access\_role](#input\_spark\_access\_role) | The name of the role which the spark access policy should be attached to. Typically this<br>is the Tecton cluster node role. | `string` | n/a | yes |
| <a name="input_spark_role_name"></a> [spark\_role\_name](#input\_spark\_role\_name) | Override the default name for emr spark role. * not recommended * | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_master_role_name"></a> [master\_role\_name](#output\_master\_role\_name) | The EMR Master role name. |
| <a name="output_spark_instance_profile_arn"></a> [spark\_instance\_profile\_arn](#output\_spark\_instance\_profile\_arn) | The spark instance profile ARN. |
| <a name="output_spark_instance_profile_name"></a> [spark\_instance\_profile\_name](#output\_spark\_instance\_profile\_name) | The spark instance profile name. |
| <a name="output_spark_role_arn"></a> [spark\_role\_arn](#output\_spark\_role\_arn) | The spark role arn. |
| <a name="output_spark_role_name"></a> [spark\_role\_name](#output\_spark\_role\_name) | The spark role name. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
