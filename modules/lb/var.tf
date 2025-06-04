variable "environment" {
  description = "Environment for the ALB (e.g., dev, staging, prod)"
  type        = string
}

variable "security_groups" {
  description = "List of security group IDs to associate with the ALB"
  type        = list(string)
  default     = []
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string

}

variable "subnets" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}


variable "default_target_group_arn" {
  description = "ARN of the default target group for the ALB"
  type        = string

}


variable "vpc_id" {
  description = "ID of the VPC where the ALB will be created"
  type        = string

}


variable "public_subnets_id" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
  default     = []

}

variable "aws_region" {
  description = "AWS region for the ALB"
  type        = string
  default     = "us-east-1"

}
