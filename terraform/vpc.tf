# CREATING A VPC (VIRTUAL PUCLIC CLOUD)
resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"

  # Required by EKS
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc"
  }
}
