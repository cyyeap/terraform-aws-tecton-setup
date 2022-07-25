variable "deployment_name" {
  type        = string
  description = "A unique deployment name."

  validation {
    condition     = length(trimprefix(var.deployment_name, "tecton-")) < 22
    error_message = <<EOM
The deployment_name must be less than 22 characters (minus a prefix of 'tecton-' as it will be
appended if not already)
EOM
  }
}

variable "instance_type" {
  type        = string
  default     = "m5.xlarge"
  description = "The EMR EC2 instance type."
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "The number of EMR EC2 CORE instances to launch."
}

variable "ebs_size" {
  type        = number
  default     = 40
  description = "The size of EBS volumes attached to EMR instances (GiB)."
}

variable "ebs_type" {
  type        = string
  default     = "gp2"
  description = <<EOV
Type of EBS volumes attached to EMR instances.Valid options are gp3, gp2, io1, standard, st1 and
sc1.
EOV
  validation {
    condition     = contains(["gp3", "gp2", "io1", "standard", "st1", "sc1"], var.ebs_type)
    error_message = "The variable ebs_type should be one of: gp3, gp2, io1, standard, st1 and sc1."
  }
}

variable "ebs_volumes_per_instance" {
  type        = number
  default     = 1
  description = <<EOV
The number of EBS volumes with this configuration to attach to each EC2 instance in the
instance group.
EOV
}

variable "subnet_ids" {
  type        = list(string)
  description = <<EOV
A list of VPC subnet IDs where the job flow should launch. Amazon EMR identifies the
best Availability Zone to launch instances according to your fleet specifications. Cannot specify
the `cc1.4xlarge` instance type for nodes of a job flow launched in an Amazon VPC.
EOV
}

variable "instance_profile_arn" {
  type        = string
  description = "The instance profile ARN for EC2 instances of the cluster assume this role."
}

variable "service_role_id" {
  type        = string
  description = "IAM role that will be assumed by the Amazon EMR service to access AWS resources."
}

variable "cluster_security_group_id" {
  type        = string
  description = "The ID of the Amazon EC2 EMR-Managed security group for the nodes."
}

variable "service_security_group_id" {
  type        = string
  description = "The ID of the Amazon EC2 service-access security group."
}

variable "additional_bootstrap_actions" {
  # TODO: once optional attributes are no longer experimental
  #  type = list(object({
  #    name = string
  #    path = string
  #    args = optional(list(string))
  #  }))

  type        = list(any)
  default     = []
  description = <<EOV
Additional bootstrap actions to perform upon EMR creation. Should be in the format of a
map with the following keys:

- `name` Name of the bootstrap action.
- `path` Location of the script to run. Either in Amazon S3 or on a local file system.
- `args` List of command line arguments to pass to the bootstrap action script.
EOV
}

variable "additional_cluster_config" {
  type        = list(any)
  description = "A JSON string for supplying list of additional configurations for the EMR cluster."
  default     = []
}

variable "enable_glue" {
  default     = false
  type        = bool
  description = <<EOV
If AWS Glue Catalog is set up and should be used to load Hive tables. Requires that
`glue_account_id` be set in addition.
EOV
}

variable "glue_account_id" {
  default     = null
  type        = string
  description = <<EOV
The ID of the AWS account containing the AWS Glue Catalog for cross-account access.
If `enable_glue` is set to true and this is not provided, the AWS account used to provision this
module will be used.
EOV
}

variable "release_label" {
  default     = "emr-6.4.0"
  type        = string
  description = "Release label for the Amazon EMR release."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to resources."
}
