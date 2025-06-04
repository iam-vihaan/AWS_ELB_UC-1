resource "aws_instance" "web-servers" {
  ami                         = var.ami_name
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnets
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = var.associate_public_ip_address
  user_data                   = var.user_data
  tags = {
    Name = "${var.project_name}"
  }
}
