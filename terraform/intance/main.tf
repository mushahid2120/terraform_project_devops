
resource "aws_instance" "my-pub-instance-1a" {
  ami                    = "ami-002f6e91abff6eb96"
  instance_type          = "t2.micro"
  subnet_id              = var.public1a_subnet_id
  vpc_security_group_ids = [var.security_group]
  key_name = "new-mum-key"
  tags = {
    Name = "pub-1a"
  }
  user_data = templatefile("${path.module}/user-data.sh", {
    rds_endpoint = var.rds_endpoint
  })

  lifecycle {
    # No create_before_destroy here; EC2 will be destroyed and replaced as needed.
    ignore_changes = [
      # Ignore changes to user_data unless there is a change in the file content
      user_data,
    ]
  }
}

  # Set a trigger to force recreation when the user-data file changes
  resource "null_resource" "user_data_trigger"{
  triggers = {
    user_data_md5 = md5(file("${path.module}/user-data.sh"))
  }

}


/*

resource "aws_instance" "my-pub-instance-1b" {
  ami           = "ami-002f6e91abff6eb96"
  instance_type = "t2.micro"
  subnet_id              = var.public1b_subnet_id
  vpc_security_group_ids = [var.security_group]
  key_name = "new-mum-key"
  tags = {
    Name = "pub-1b"
  }
}

resource "aws_instance" "my-priv-instance-1a" {
  ami           = "ami-002f6e91abff6eb96"
  instance_type = "t2.micro"
  subnet_id              = var.priv1a_subnet_id
  vpc_security_group_ids = [var.security_group]
  key_name = "new-mum-key"
  tags = {
    Name = "priv-1a"
  }
}

resource "aws_instance" "my-priv-instance-1b" {
  ami           = "ami-002f6e91abff6eb96"
  instance_type = "t2.micro"
  subnet_id              = var.priv1b_subnet_id
  vpc_security_group_ids = [var.security_group]
  key_name = "new-mum-key"
  tags = {
    Name = "priv-1b"
  }
}

*/