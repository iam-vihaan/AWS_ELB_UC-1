provider "aws" {
  region = "us-east-1"
}



module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  vpc_name           = "demo-alb-vpc"
  environment        = var.environment
  public_cidr_block  = var.public_subnet_cidrs
  private_cidr_block = var.private_subnet_cidrs
  azs                = var.availability_zones
  owner              = "demo-alb"
}

module "NGW" {
  source           = "./modules/NGW"
  public_subnet_id = module.network.public_subnets_id[0]
  private_rt_ids   = module.network.private_route_table_ids
  vpc_name         = module.network.vpc_name
}

module "SecurityGroup" {
  source        = "./modules/SecurityGroup"
  vpc_id        = module.network.vpc_id
  environment   = var.environment
  vpc_name      = module.network.vpc_name
  ingress_ports = [80, 443, 22, 8080, 3306, 9000, 9100]
}


module "homepage_instance" {
  source                      = "./modules/ec2"
  vpc_name                    = module.network.vpc_name
  ami_name                    = var.ami_id
  env                         = var.environment
  instance_type               = var.instance_type
  key_name                    = var.key_name
  private_subnets             = module.network.private_subnets_id[0]
  project_name                = "demo-instance-web-1"
  sg_id                       = module.sg.sg_id
  associate_public_ip_address = false
  user_data    = <<-EOF
                 #!/bin/bash
                 echo "<h1>Welcome to Homepage</h1>" > /var/www/html/index.html
                 yum install -y nginx
                 systemctl start nginx
                 systemctl enable nginx
                 echo "<h1>Home</h1>" > /usr/share/nginx/html/index.html
                 echo "<p>demo-instance-web-1</p>" >> /usr/share/nginx/html/index.html
                 EOF
}

module "images_instance" {
  source                      = "./modules/ec2"
  vpc_name                    = module.network.vpc_name
  ami_name                    = var.ami_id
  env                         = var.environment
  instance_type               = var.instance_type
  key_name                    = var.key_name
  private_subnets             = module.network.private_subnets_id[1]
  project_name                = "demo-instance-web-2"
  sg_id                       = module.sg.sg_id
  associate_public_ip_address = false
 user_data    = <<-EOF
                #!/bin/bash
                yum install -y nginx
                systemctl start nginx
                systemctl enable nginx
                mkdir -p /usr/share/nginx/html/images
                echo "<h1>Image</h1>" > /usr/share/nginx/html/images/index.html
                echo "<p>demo-instance-web-2</p>" >> /usr/share/nginx/html/images/index.html
                EOF
}

module "register_instance" {
  source                      = "./modules/ec2"
  vpc_name                    = module.network.vpc_name
  ami_name                    = var.ami_id
  env                         = var.environment
  instance_type               = var.instance_type
  key_name                    = var.key_name
  private_subnets             = module.network.private_subnets_id[2]
  project_name                = "demo-instance-web-3"
  sg_id                       = module.sg.sg_id
  associate_public_ip_address = false
    user_data    = <<-EOF
                   #!/bin/bash
                   yum install -y nginx
                   systemctl start nginx
                   systemctl enable nginx
                   mkdir -p /usr/share/nginx/html/register
                   echo "<h1>Register</h1>" > /usr/share/nginx/html/register/index.html
                   echo "<p>demo-instance-web-3</p>" >> /usr/share/nginx/html/register/index.html
                   EOF
}

module "homepage_tg" {
  source    = "./modules/target_group"
  name      = "homepage-tg"
  vpc_id    = module.network.vpc_id
  target_id = module.homepage_instance.instance_id
}

module "images_tg" {
  source    = "./modules/target_group"
  name      = "images-tg"
  vpc_id    = module.network.vpc_id
  target_id = module.images_instance.instance_id
}

module "register_tg" {
  source    = "./modules/target_group"
  name      = "register-tg"
  vpc_id    = module.network.vpc_id
  target_id = module.register_instance.instance_id
}

module "lb" {
  source                   = "./modules/lb"
  alb_name                 = "demo-bayer-alb" # Ensure this matches var.name in alb module
  security_groups          = var.sg_id
  vpc_id                   = module.network.vpc_id
  environment              = var.environment
  subnets                  = [module.network.public_subnets_id[0], module.network.public_subnets_id[1], module.network.public_subnets_id[2]] # Using 2 public subnets for HA
  default_target_group_arn = module.homepage_tg.target_group_arn
}



resource "aws_lb_listener_rule" "images_rule" {
  listener_arn = module.alb.listener_arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = module.images_tg.target_group_arn
  }

  condition {
    path_pattern {
      values = ["/images*"]
    }
  }
}

resource "aws_lb_listener_rule" "register_rule" {
  listener_arn = module.alb.listener_arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = module.register_tg.target_group_arn
  }

  condition {
    path_pattern {
      values = ["/register*"]
    }
  }
}


