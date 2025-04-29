#Frontend Launch Template
resource "aws_launch_template" "frontend_temp" {
  name_prefix   = "frontend_template"
  image_id      = "ami-0f1dcc636b69a6438"
  instance_type = "t2.micro"
  key_name = "new-mum-key"
  user_data = base64encode(templatefile("${path.module}/frontend-user-data.sh", {
    alb_endpoint = aws_lb.backend_alb.dns_name,
    frontend_lb_endpoint= lower(aws_lb.frontend_alb.dns_name)
  }))
  vpc_security_group_ids = [var.security_group]
  lifecycle {
    create_before_destroy = true
  }
}

#Frontend Autoscaling Group
resource "aws_autoscaling_group" "frontend-myauto-sg" {
  depends_on = [
    aws_lb.backend_alb
  ]
  name                      = "frontend-autoscaling-group"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  launch_template {
  id      = aws_launch_template.frontend_temp.id
  version = "$Latest"
}
  vpc_zone_identifier       = [var.public1a_subnet_id , var.public1b_subnet_id ]

  lifecycle {
    create_before_destroy = true
  }
}

# Frontend Autoscaling Group and Load Balancer
resource "aws_autoscaling_attachment" "asg_attachment_frontend" {
  autoscaling_group_name = aws_autoscaling_group.frontend-myauto-sg.name
  lb_target_group_arn   = aws_lb_target_group.frontend-tg.arn
}




# Backend Launch Template
resource "aws_launch_template" "backend_temp" {
  name_prefix   = "backedn_template"
  image_id      = "ami-0f1dcc636b69a6438"
  instance_type = "t2.micro"
  key_name = "new-mum-key"
  user_data = base64encode(templatefile("${path.module}/backend-user-data.sh", {
    rds_endpoint = var.rds_endpoint,
  }))
  vpc_security_group_ids = [var.security_group]
  lifecycle {
    create_before_destroy = true
  }
}

#Backend AutoScaling Group
resource "aws_autoscaling_group" "backend-myauto-sg" {
  depends_on = [
    aws_lb.backend_alb
  ]
  name                      = "backend-autoscaling-group"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  launch_template {
  id      = aws_launch_template.backend_temp.id
  version = "$Latest"
}
  vpc_zone_identifier       = [var.priv1a_subnet_id , var.priv1b_subnet_id ]

  lifecycle {
    create_before_destroy = true
  }
}

#Attachment Autoscaling Group and Load Balancer
resource "aws_autoscaling_attachment" "asg_attachment_backend" {
  autoscaling_group_name = aws_autoscaling_group.backend-myauto-sg.name
  lb_target_group_arn   = aws_lb_target_group.backend-tg.arn
}