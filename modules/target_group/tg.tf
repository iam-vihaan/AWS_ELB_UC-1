
resource "aws_lb_target_group" "demo-tg" {
  name     = var.name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  # Remove target_type or set to "instance" (default)
  target_type = "instance"

  health_check {
    path                = "/"
    port                = "80"
    interval            = 30
    timeout             = 5
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }
}

resource "aws_lb_target_group_attachment" "demo-tg-attachment" {
  target_group_arn = aws_lb_target_group.demo-tg.arn
  target_id        = var.target_id
  port             = 80
}
