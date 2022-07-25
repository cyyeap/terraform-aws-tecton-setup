resource "aws_security_group" "cluster_security_group" {
  count = local.has_cluster_security_group_id ? 0 : 1

  name        = "tecton-emr"
  description = "A security group that EMR clusters created by Tecton will use to communicate internally"
  vpc_id      = var.vpc_id
  tags = merge(local.tags, {
    "tecton-security-group-emr-usage" = "master,core&task"
    "Name"                            = "tecton-emr"
  })
}

resource "aws_security_group_rule" "security_group_full_egress" {
  count = var.enable_security_group_rules ? 1 : 0

  description       = "Allow full egress for emr to pull pip packages and send metrics"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.cluster_security_group_id
  type              = "egress"
}

resource "aws_security_group_rule" "security_group_self_ingress" {
  count = var.enable_security_group_rules ? 1 : 0

  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = local.cluster_security_group_id
  source_security_group_id = local.cluster_security_group_id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group" "service_security_group" {
  count = local.has_service_security_group_id ? 0 : 1

  name        = "tecton-service-emr-security"
  description = "A security group that EMR clusters created by Tecton will use to communicate with EMR services"
  vpc_id      = var.vpc_id
  tags = merge(local.tags, {
    "tecton-security-group-emr-usage" = "service-access"
    "Name"                            = "tecton-service-emr"
  })
}

resource "aws_security_group_rule" "security_group_service_ingress" {
  count = var.enable_security_group_rules ? 1 : 0

  description              = "Allow ingress from emr-service-sg to emr-sg on 8443"
  from_port                = 8443
  protocol                 = "tcp"
  security_group_id        = local.cluster_security_group_id
  source_security_group_id = local.service_security_group_id
  to_port                  = 8443
  type                     = "ingress"
}

resource "aws_security_group_rule" "service_security_group_ingress" {
  count = var.enable_security_group_rules ? 1 : 0

  description              = "Allow ingress from emr-sg to emr-service-sg on 9443"
  from_port                = 9443
  protocol                 = "tcp"
  security_group_id        = local.service_security_group_id
  source_security_group_id = local.cluster_security_group_id
  to_port                  = 9443
  type                     = "ingress"
}

resource "aws_security_group_rule" "service_security_group_egress" {
  count = var.enable_security_group_rules ? 1 : 0

  description              = "Allow egress from emr-service-sg to emr-sg on 8443"
  from_port                = 8443
  protocol                 = "tcp"
  source_security_group_id = local.cluster_security_group_id
  security_group_id        = local.service_security_group_id
  to_port                  = 8443
  type                     = "egress"
}
