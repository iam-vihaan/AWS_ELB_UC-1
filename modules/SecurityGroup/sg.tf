resource "aws_security_group" "ec2_sg" {
  name        = "${var.vpc_name}-ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.alb_sg_id == null ? ["0.0.0.0/0"] : []
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.vpc_name}-ec2-sg"
    Environment = var.environment
  }
}
