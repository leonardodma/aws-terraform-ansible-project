/* Elastic Ips: By using an Elastic IP address, you can mask 
the failure of an instance or software by rapidly remapping the 
address to another instance in your account */
resource "aws_eip" "public_eip" {
  depends_on = [
    aws_internet_gateway.vpc_internet_gateway
  ]
}
