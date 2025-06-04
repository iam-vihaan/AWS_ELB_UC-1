variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "environment" {
  description = "Environment for the VPC (e.g., dev, staging, prod)"
  type        = string
}

# variable "service_ports" {
#   description = "List of service ports to be allowed in the security group"
#   type        = list(number)
#   default     = [443, 80, 22, 3389, 445, 8080]
# }

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "alb_sg_id" {
  description = "The security group ID of the ALB"
  type        = string
  default     = null
}

variable "ingress_ports" {
  description = "List of ingress ports for the security group"
  type        = list(number)
  default     = [80, 443]

}
