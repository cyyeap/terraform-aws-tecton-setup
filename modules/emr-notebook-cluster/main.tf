resource "aws_emr_cluster" "notebook" {
  name          = format("tecton-%s-notebook-cluster", var.deployment_name)
  release_label = var.release_label
  applications  = ["Spark", "Livy", "Hive", "JupyterEnterpriseGateway"]
  service_role  = var.service_role_id

  ec2_attributes {
    subnet_ids                        = var.subnet_ids
    emr_managed_master_security_group = var.cluster_security_group_id
    emr_managed_slave_security_group  = var.cluster_security_group_id
    instance_profile                  = var.instance_profile_arn
    service_access_security_group     = var.service_security_group_id
  }

  master_instance_group {
    instance_type = var.instance_type
  }

  core_instance_group {
    instance_type  = var.instance_type
    instance_count = var.instance_count

    ebs_config {
      size                 = var.ebs_size
      type                 = var.ebs_type
      volumes_per_instance = var.ebs_volumes_per_instance
    }
  }

  dynamic "bootstrap_action" {
    iterator = bootstrap_action
    for_each = concat(local.bootstrap_action, var.additional_bootstrap_actions)
    content {
      name = lookup(bootstrap_action.value, "name", null)
      path = lookup(bootstrap_action.value, "path", null)
      args = lookup(bootstrap_action.value, "args", null)
    }
  }

  configurations_json = (local.has_glue ?
    jsonencode(concat(local.hive_config, local.base_config, var.additional_cluster_config)) :
    jsonencode(concat(local.base_config, var.additional_cluster_config))
  )

  step {
    action_on_failure = "TERMINATE_CLUSTER"
    name              = "Setup Hadoop Debugging"

    hadoop_jar_step {
      jar  = "command-runner.jar"
      args = ["state-pusher-script"]
    }
  }

  tags = merge(
    local.tags,
    { notebook = "true" },
  )
}
