# Tecton Basic VPC Deployment Example

See [modules/basic-vpc](../../modules/basic-vpc) for more details.

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
| <a name="module_tecton"></a> [tecton](#module\_tecton) | ../../modules/basic-vpc/ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cross_account_assume_role_allowed_ids"></a> [cross\_account\_assume\_role\_allowed\_ids](#input\_cross\_account\_assume\_role\_allowed\_ids) | A list of AWS account IDs allowed to assume the cross-account role(s). This should be an<br>AWS account ID that is provided by your Tecton rep. | `list(string)` | n/a | yes |
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | A unique deployment name. | `string` | n/a | yes |
| <a name="input_spark_role_name"></a> [spark\_role\_name](#input\_spark\_role\_name) | The name of an existing spark role to attach policies to. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
