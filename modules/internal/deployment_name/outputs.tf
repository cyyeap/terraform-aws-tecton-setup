output "deployment_name" {
  description = "A unique deployment name, prepended with `tecton-` if not already."
  value       = local.deployment_name
}
