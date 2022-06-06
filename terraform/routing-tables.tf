# Creating route table from internet to internet gateway
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_internet_gateway.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Creating from public subnet nat gateway to internet gateway
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_nat_gateway.id
  }

  tags = {
    Name = "public-rt"
  }
}
