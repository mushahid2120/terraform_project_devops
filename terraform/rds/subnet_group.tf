resource "aws_db_subnet_group" "mysub-group" {
  name       = "mydb-subnet-group"
  subnet_ids = [var.priv2a_subnet_id , var.priv2b_subnet_id]

  tags = {
    Name = "My DB subnet group"
  }
}