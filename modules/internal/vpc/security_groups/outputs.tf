output "ids" {
  description = "A map of the security group IDs."
  value = merge({
    cluster = aws_security_group.cluster.id,
    node    = aws_security_group.node.id,
    rds     = aws_security_group.rds.id,
    },
    var.enable_cluster_vpc_endpoint ? {
      cluster_vpc_endpoint = aws_security_group.cluster_vpc_endpoint[0].id
    } : {}
  )
}

output "cluster_vpc_endpoint_id" {
  description = "If deployment_type is vpc, the ID of the cluster ingress VPC endpoint."
  value       = var.enable_cluster_vpc_endpoint ? aws_security_group.cluster_vpc_endpoint[0].id : null
}
