output "ids" {
  description = "A map of the security group IDs."
  value = {
    cluster = local.cluster_security_group_id,
    service = local.service_security_group_id,
  }
}
