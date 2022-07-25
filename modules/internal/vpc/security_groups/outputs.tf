output "ids" {
  description = "A map of the security group IDs."
  value = {
    "control" = aws_security_group.control.id,
    "node"    = aws_security_group.node.id,
    "rds"     = aws_security_group.rds.id,
  }
}

output "ingress_vpc_endpoint_id" {
  description = "If deployment_type is vpc, the ID of the ingress VPC endpoint."
  value       = var.enable_ingress_vpc_endpoint ? aws_security_group.ingress_vpc_endpoint[0].id : null
}
