# Tecton Cross-VPC Privatelink Example

This example demonstrates how to connect to a pre-existing Tecton VPC endpoint service from a different VPC.

## Prerequisite
* A pre-existing VPC endpoint service serving Tecton endpoints

## Usage

1. Create a [`tfvars`](https://www.terraform.io/language/values/variables#variable-definitions-tfvars-files)
  file with the appropriate [variable inputs](#Inputs)
2. Ensure the AWS provider information correctly matches the AWS credentials for the account(s) to
  be provisioned into
3. Follow the typical Terraform workflow:

    ```shell
    terraform init
    terraform plan
    terraform apply
    ```
4. [Accept connection request](https://docs.aws.amazon.com/vpc/latest/privatelink/configure-endpoint-service.html#accept-reject-connection-requests) from the VPC endpoint service side
5. Add AWS account/IAM user/IAM role (automatically captured by [Output caller_identity](#output\_caller\_identity))  to "Allowed Principals" from VPC endpoint service side
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_privatelink-corss-vpc"></a> [privatelink-corss-vpc](#module\_privatelink-corss-vpc) | ../../modules/privatelink-cross-vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | DNS name for Tecton servcies | `string` | n/a | yes |
| <a name="input_vpc_endpoint_service_name"></a> [vpc\_endpoint\_service\_name](#input\_vpc\_endpoint\_service\_name) | Name of the pre-existing VPC endpoint service to connect to | `string` | n/a | yes |
| <a name="input_vpc_endpoint_subnet_ids"></a> [vpc\_endpoint\_subnet\_ids](#input\_vpc\_endpoint\_subnet\_ids) | Private subnet ids where to create VPC endpiont | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID from which to create the VPC endpoint | `string` | n/a | yes |
| <a name="input_vpc_endpoint_security_group_egress_cidrs"></a> [vpc\_endpoint\_security\_group\_egress\_cidrs](#input\_vpc\_endpoint\_security\_group\_egress\_cidrs) | Egress CIDR blocks of the VPC endpiont security group | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_vpc_endpoint_security_group_ingress_cidrs"></a> [vpc\_endpoint\_security\_group\_ingress\_cidrs](#input\_vpc\_endpoint\_security\_group\_ingress\_cidrs) | Ingress CIDR blocks of the VPC endpiont security group | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_caller_identity"></a> [caller\_identity](#output\_caller\_identity) | Current caller identity |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
