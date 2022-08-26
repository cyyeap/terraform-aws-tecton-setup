resource "aws_security_group" "rds" {
  name = "${local.deployment_name}-rds"

  description = "Tecton RDS postgres"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    description     = "Allow Tecton nodes to talk to RDS"
    security_groups = [aws_security_group.node.id]
  }

  tags = merge(
    var.tags,
    {
      Name = "${local.deployment_name}-rds"
    }
  )
}

resource "aws_security_group" "cluster" {
  name        = "${local.deployment_name}-cluster"
  description = "Tecton cluster control"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags,
    {
      Name = local.deployment_name
    }
  )
}

resource "aws_security_group_rule" "public_ingress" {
  cidr_blocks       = ["0.0.0.0/0"] # TODO: make variable
  description       = "Allow communication with the Tecton cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.cluster.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group" "node" {
  name        = "${local.deployment_name}-node"
  description = "Tecton cluster nodes"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      "Name"                                           = "${local.deployment_name}-node",
      "kubernetes.io/cluster/${local.deployment_name}" = "owned"
    }
  )
}

resource "aws_security_group_rule" "node_ingress_self" {
  description              = "Allow nodes to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.node.id
  source_security_group_id = aws_security_group.node.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "node_ingress_cluster" {
  description              = "Allow nodes to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.node.id
  source_security_group_id = aws_security_group.cluster.id
  to_port                  = 65535
  type                     = "ingress"

}

resource "aws_security_group_rule" "cluster_ingress_node_https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.cluster.id
  source_security_group_id = aws_security_group.node.id
  to_port                  = 443
  type                     = "ingress"

}

resource "aws_security_group_rule" "lb_to_cluster_ingress_port" {
  for_each = local.listener_ports

  security_group_id = aws_security_group.node.id
  type              = "ingress"
  from_port         = each.value.port
  to_port           = each.value.port
  protocol          = "TCP"
  description       = "Allow access from the NLB to the ingress port(s)"

  ## TODO: move this to variable description
  # For the public NLB, we also allow the public NAT gateway IPs because Tecton requests from the VPC
  # will go through the corresponding NAT gateway first.
  # For the private NLB, we also allow the private CIDR block(s) of the VPC because
  # the Tecton requests from the VPC will be routed directly to the NLB.
  cidr_blocks = local.has_ingress_allowed_cidr_blocks ? local.lb_ingress_cidr_blocks : ["0.0.0.0/0"]
}

resource "aws_security_group" "cluster_vpc_endpoint" {
  count = var.enable_cluster_vpc_endpoint ? 1 : 0

  name = format(
    "%s-ingress-vpc-endpoint", local.deployment_name,
  )
  description = "Tecton cluster ingress VPC Endpoint security group for in-VPC communication"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      "Name" = format(
        "%s-ingress-vpc-endpoint", local.deployment_name,
      ),
      format(
        "kubernetes.io/cluster/%s", local.deployment_name,
      ) = "owned", # TODO: needed?
    }
  )
}

resource "aws_security_group_rule" "cluster_vpc_endpoint" {
  count = var.enable_cluster_vpc_endpoint ? 1 : 0

  description              = "Allow all ingress from Tecton cluster nodes"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.cluster_vpc_endpoint[0].id
  source_security_group_id = aws_security_group.node.id
  to_port                  = 65535
  type                     = "ingress"
}
