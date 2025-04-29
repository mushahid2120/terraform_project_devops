resource "aws_nat_gateway" "mynat_gateway" {
  allocation_id = aws_eip.my-eip.id
  subnet_id     = aws_subnet.subnet_pub1a.id

  tags = {
    Name = "myNAT Gateway"
  }
}

resource "aws_eip" "my-eip" {
  domain = "vpc"
}