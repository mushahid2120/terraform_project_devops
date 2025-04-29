
#FrontEnd LoadBalancer 

resource "aws_lb" "frontend_alb" {
  depends_on = [
    aws_lb.backend_alb
  ]
  name               = "frontendALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [ var.security_group ]
  subnets            = [ var.public1a_subnet_id , var.public1b_subnet_id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

#Frontend Listener
resource "aws_lb_listener" "frontend_listener" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-tg.arn
  }
}


#Backend Load Balancer
resource "aws_lb" "backend_alb" {
  name               = "backendALB"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [ var.security_group ]
  subnets            = [ var.priv1a_subnet_id , var.priv1b_subnet_id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

#Backend Listener

resource "aws_lb_listener" "backend_listener" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend-tg.arn
  }
}