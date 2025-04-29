resource "aws_security_group" "mypub_sg" {
  description = "Allow All inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  tags = {
    Name = "public-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_allow_all" {
  security_group_id = aws_security_group.mypub_sg.id
  cidr_ipv4         = "0.0.0.0/0" 
  ip_protocol       = "-1"
}


resource "aws_vpc_security_group_egress_rule" "egress_allow_all" {
  security_group_id = aws_security_group.mypub_sg.id
  cidr_ipv4         = "0.0.0.0/0" 
  ip_protocol       = "-1"
}
