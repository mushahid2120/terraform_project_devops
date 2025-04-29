#FrontEnd Target Group
resource "aws_lb_target_group" "frontend-tg" {
  name     = "frontend-tg"
  port     = 5173
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

#BackEnd Target group
resource "aws_lb_target_group" "backend-tg" {
  name     = "backend-tg"
  port     = 4000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
   health_check {
    path                = "/page"
    protocol            = "HTTP"
  }
}


# resource "aws_lb_target_group_attachment" "att_tg_instance" {
#   target_group_arn = aws_lb_target_group.mytg.arn
#   target_id        = "i-0544be3a8033e9c77"
#   port             = 80
# }

