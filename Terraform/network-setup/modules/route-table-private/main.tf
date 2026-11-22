resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.route_table_name
  }
}