locals {
  region = data.aws_region.current.name
  tags = merge(
    var.tags,
    {
      format("tecton-accessible:%s", var.deployment_name) = "true",
      tecton-owned                                        = "true"
    }
  )

  has_glue            = var.enable_glue && var.glue_account_id != null
  has_glue_account_id = var.glue_account_id != null
  glue_account_id     = local.has_glue_account_id ? var.glue_account_id : data.aws_caller_identity.current.id
  hive_config = [
    {
      Classification : "hive-site",
      Properties : {
        "hive.metastore.client.factory.class" : "com.amazonaws.glue.catalog.metastore.AWSGlueDataCatalogHiveClientFactory",
        "hive.metastore.glue.catalogid" : local.glue_account_id
      }
    },
    {
      Classification : "spark-defaults",
      Properties : {
        "hive.metastore.client.factory.class" : "com.amazonaws.glue.catalog.metastore.AWSGlueDataCatalogHiveClientFactory",
        "hive.metastore.glue.catalogid" : local.glue_account_id
      }
    },
    {
      Classification : "spark-hive-site",
      Properties : {
        "hive.metastore.client.factory.class" : "com.amazonaws.glue.catalog.metastore.AWSGlueDataCatalogHiveClientFactory",
        "hive.metastore.glue.catalogid" : local.glue_account_id
      }
    }
  ]

  base_config = [
    {
      Classification : "livy-env",
      Properties : {}
      Configurations : [
        {
          Classification : "export",
          Properties : {
            "CLUSTER_REGION" : local.region,
            "TECTON_CLUSTER_NAME" : var.deployment_name
          }
        }
      ]
    },
    {
      Classification : "yarn-env",
      Properties : {},
      Configurations : [
        {
          Classification : "export",
          Properties : {
            "CLUSTER_REGION" : local.region,
            "TECTON_CLUSTER_NAME" : var.deployment_name
          }
        }
      ]
    }
  ]

  /* bootstrap_regions
      ---
      EMR bootstrapping only supports bootstrap scripts from s3 buckets. The current way the s3
      client within EMR is retrieving the bootstrap scripts causes a failure to retrieve the file in
      certain regions. Currently Tecton supports serving bootstrap scripts from the following
      regions. (including us-west-2 by default) Reach out to customer support for further information.
  */
  bootstrap_regions = {
    "eu-central-1" : "-eu-central-1",
    "eu-west-1" : "-eu-west-1",
    "us-east-2" : "-us-east-2",
  }

  bootstrap_action = [
    {
      name = "tecton_emr_setup"
      path = format(
        "s3://tecton.ai.public%s/install_scripts/setup_emr_notebook_cluster_v2.sh",
        lookup(local.bootstrap_regions, local.region, ""),
      )
    }
  ]
}
