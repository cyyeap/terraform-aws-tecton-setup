module "deployment_name" {
  source          = "../../deployment_name"
  deployment_name = var.deployment_name
}

locals {
  deployment_name = module.deployment_name.deployment_name

  has_ingress_allowed_cidr_blocks = var.ingress_allowed_cidr_blocks != null
  lb_ingress_cidr_blocks          = var.ingress_load_balancer_public ? local.lb_ingress_public_cidr_blocks : local.lb_ingress_private_cidr_blocks
  lb_ingress_private_cidr_blocks  = concat(var.ingress_allowed_cidr_blocks, [data.aws_vpc.vpc[0].cidr_block])
  lb_ingress_public_cidr_blocks   = concat(var.ingress_allowed_cidr_blocks, formatlist("%s/32", var.nat_gateway_ips))

  listener_ports = {
    # These must match the nodePorts of the Ingress service. They match Tecton's public ingress.
    # The plaintext is just for redirection to https.
    plaintext = {
      port     = 31080
      protocol = "TCP"
    }
    tls = {
      port     = 31443
      protocol = "TLS"
    }
  }
}
