# emr-notebook-cluster

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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_emr_cluster.notebook](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/emr_cluster) | resource |
| [aws_secretsmanager_secret.api_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.tecton_api_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.api_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_security_group_id"></a> [cluster\_security\_group\_id](#input\_cluster\_security\_group\_id) | The ID of the Amazon EC2 EMR-Managed security group for the nodes. | `string` | n/a | yes |
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | A unique deployment name. | `string` | n/a | yes |
| <a name="input_instance_profile_arn"></a> [instance\_profile\_arn](#input\_instance\_profile\_arn) | The instance profile ARN for EC2 instances of the cluster assume this role. | `string` | n/a | yes |
| <a name="input_service_role_id"></a> [service\_role\_id](#input\_service\_role\_id) | IAM role that will be assumed by the Amazon EMR service to access AWS resources. | `string` | n/a | yes |
| <a name="input_service_security_group_id"></a> [service\_security\_group\_id](#input\_service\_security\_group\_id) | The ID of the Amazon EC2 service-access security group. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of VPC subnet IDs where the job flow should launch. Amazon EMR identifies the<br>best Availability Zone to launch instances according to your fleet specifications. Cannot specify<br>the `cc1.4xlarge` instance type for nodes of a job flow launched in an Amazon VPC. | `list(string)` | n/a | yes |
| <a name="input_additional_bootstrap_actions"></a> [additional\_bootstrap\_actions](#input\_additional\_bootstrap\_actions) | Additional bootstrap actions to perform upon EMR creation. Should be in the format of a<br>map with the following keys:<br><br>- `name` Name of the bootstrap action.<br>- `path` Location of the script to run. Either in Amazon S3 or on a local file system.<br>- `args` List of command line arguments to pass to the bootstrap action script. | `list(any)` | `[]` | no |
| <a name="input_additional_cluster_config"></a> [additional\_cluster\_config](#input\_additional\_cluster\_config) | A JSON string for supplying list of additional configurations for the EMR cluster. | `list(any)` | `[]` | no |
| <a name="input_ebs_size"></a> [ebs\_size](#input\_ebs\_size) | The size of EBS volumes attached to EMR instances (GiB). | `number` | `40` | no |
| <a name="input_ebs_type"></a> [ebs\_type](#input\_ebs\_type) | Type of EBS volumes attached to EMR instances.Valid options are gp3, gp2, io1, standard, st1 and<br>sc1. | `string` | `"gp2"` | no |
| <a name="input_ebs_volumes_per_instance"></a> [ebs\_volumes\_per\_instance](#input\_ebs\_volumes\_per\_instance) | The number of EBS volumes with this configuration to attach to each EC2 instance in the<br>instance group. | `number` | `1` | no |
| <a name="input_enable_glue"></a> [enable\_glue](#input\_enable\_glue) | If AWS Glue Catalog is set up and should be used to load Hive tables. Requires that<br>`glue_account_id` be set in addition. | `bool` | `false` | no |
| <a name="input_glue_account_id"></a> [glue\_account\_id](#input\_glue\_account\_id) | The ID of the AWS account containing the AWS Glue Catalog for cross-account access.<br>If `enable_glue` is set to true and this is not provided, the AWS account used to provision this<br>module will be used. | `string` | `null` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | The number of EMR EC2 CORE instances to launch. | `number` | `1` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The EMR EC2 instance type. | `string` | `"m5.xlarge"` | no |
| <a name="input_release_label"></a> [release\_label](#input\_release\_label) | Release label for the Amazon EMR release. | `string` | `"emr-6.4.0"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
