# CREATING A INTERNET GATEWAY

# Creating an internet gateway to access the subnets
resource "aws_internet_gateway" "vpc_internet_gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "vpc-igw"
  }
}