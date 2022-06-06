resource "aws_nat_gateway" "public_nat_gateway" {
  # Elastic IP address
  allocation_id = aws_eip.public_eip.id
  # Subnet for Django
  subnet_id = aws_subnet.public_subnet.id

  tags = {
    Name : "public-nat-gateway"
  }
}
