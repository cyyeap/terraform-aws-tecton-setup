# Tecton EMR VPC Deployment Example

See [modules/emr-vpc](../../modules/emr-vpc) for more details.

## Usage

* Create a [`tfvars`](https://www.terraform.io/language/values/variables#variable-definitions-tfvars-files)
  file with the appropriate [variable inputs](#Inputs)
* Ensure the AWS provider information correctly matches the AWS credentials for the account(s) to
  be provisioned into
* Follow the typical Terraform workflow:

    ```shell
    terraform init
    terraform plan
    terraform apply
    ```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_emr_notebook_cluster"></a> [emr\_notebook\_cluster](#module\_emr\_notebook\_cluster) | ../../modules/emr-notebook-cluster | n/a |
| <a name="module_tecton"></a> [tecton](#module\_tecton) | ../../modules/emr-vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cross_account_assume_role_allowed_ids"></a> [cross\_account\_assume\_role\_allowed\_ids](#input\_cross\_account\_assume\_role\_allowed\_ids) | A list of AWS account IDs allowed to assume the cross-account role(s). This should be an<br>AWS account ID that is provided by your Tecton rep. | `list(string)` | n/a | yes |
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | A unique deployment name. | `string` | n/a | yes |
| <a name="input_enable_glue_on_notebook_cluster"></a> [enable\_glue\_on\_notebook\_cluster](#input\_enable\_glue\_on\_notebook\_cluster) | If AWS Glue Catalog is set up and should be used to load Hive tables. Requires that<br>`glue_account_id` be set in addition. | `bool` | `false` | no |
| <a name="input_enable_notebook_cluster"></a> [enable\_notebook\_cluster](#input\_enable\_notebook\_cluster) | * This can not be enabled until the Tecton cluster is fully provisioned on the Tecton side *<br>Toggle enabling the EMR notebook cluster. Default: false. | `bool` | `false` | no |
| <a name="input_notebook_cluster_glue_account_id"></a> [notebook\_cluster\_glue\_account\_id](#input\_notebook\_cluster\_glue\_account\_id) | The ID of the AWS account containing the AWS Glue Catalog for cross-account access.<br>If `enable_glue` is set to true and this is not provided, the AWS account used to provision this<br>module will be used. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to deploy into. | `string` | `"us-west-2"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
