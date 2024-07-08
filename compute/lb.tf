resource "aws_lb" "main" {
  count              = var.is_web_faced ? 1 : 0
  name               = var.service_name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [var.security_group_alb]
}

resource "aws_lb_target_group" "main" {
  count       = var.is_web_faced ? 1 : 0
  name        = format("%s-target", var.service_name)
  port        = var.port
  target_type = "ip"
  protocol    = "HTTP"
  vpc_id      = var.vpc

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}

resource "aws_lb_listener" "main" {
  count             = var.is_web_faced ? 1 : 0
  load_balancer_arn = aws_lb.main[0].arn
  port              = var.port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main[0].arn
  }
}