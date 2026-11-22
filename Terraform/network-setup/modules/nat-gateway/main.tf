# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "backend-nat-eip"
  }
}

# NAT Gateway - must be in a PUBLIC subnet
resource "aws_nat_gateway" "backend_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.pubic_subnet_for_nat

  tags = {
    Name = var.nat_gateway_name
  }
}