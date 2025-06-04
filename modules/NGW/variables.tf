variable "public_subnet_id" {
  description = "The public subnet ID for the NAT Gateway"
  type        = string
}

variable "private_rt_ids" {
  description = "List of private route table IDs"
  type        = list(string)
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}
