# Creating an subnet for django applications - PUBLIC
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.0.0/18"
  availability_zone = "us-east-1a"

  # Required from EKS
  map_public_ip_on_launch = true

  tags = {
    Name                              = "public-subnet"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1 # To EKS load balacers 

  }
}

# Creating an subnet for sgbd postgresql - PRIVATE
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.64.0/18"
  availability_zone = "us-east-1b"

  tags = {
    Name                        = "private-subnet"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1 # Deploy privite Load Balancers
  }
}
