# Routing Table for Internet Gateway 
resource "aws_route_table" "rt-igw" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygw.id
  }
  tags = {
    Name = "my-routing-table"
  }
}

resource "aws_route_table_association" "pub-1a-igw" {
  subnet_id      = aws_subnet.subnet_pub1a.id
  route_table_id = aws_route_table.rt-igw.id
}

resource "aws_route_table_association" "pub-1b-igw" {
  subnet_id      = aws_subnet.subnet_pub1b.id
  route_table_id = aws_route_table.rt-igw.id
}


#Routing Table for NAT Gateway 
resource "aws_route_table" "rt-nat" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.mynat_gateway.id
  }
}

resource "aws_route_table_association" "priv1a-nat-rt" {
  subnet_id      = aws_subnet.subnet_priv1a.id
  route_table_id = aws_route_table.rt-nat.id
}
resource "aws_route_table_association" "priv1b-nat-rt" {
  subnet_id      = aws_subnet.subnet_priv1b.id
  route_table_id = aws_route_table.rt-nat.id
}