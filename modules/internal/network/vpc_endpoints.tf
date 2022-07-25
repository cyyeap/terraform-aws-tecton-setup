resource "aws_vpc_endpoint" "dynamodb" {
  count = var.enable_dynamodb_vpc_endpoint && !local.has_dynamodb_vpc_endpoint_id ? 1 : 0

  vpc_id       = local.vpc_id
  service_name = "com.amazonaws.${local.region}.dynamodb"
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb" {
  count = var.enable_dynamodb_vpc_endpoint ? length(aws_route_table.private) : 0

  vpc_endpoint_id = local.dynamodb_vpc_endpoint_id
  route_table_id  = aws_route_table.private[count.index].id
}

resource "aws_vpc_endpoint" "s3" {
  count = var.enable_s3_vpc_endpoint && !local.has_s3_vpc_endpoint_id ? 1 : 0

  vpc_id       = local.vpc_id
  service_name = "com.amazonaws.${local.region}.s3"
}

resource "aws_vpc_endpoint_route_table_association" "s3" {
  count = var.enable_s3_vpc_endpoint ? length(aws_route_table.private) : 0

  vpc_endpoint_id = local.s3_vpc_endpoint_id
  route_table_id  = aws_route_table.private[count.index].id
}
