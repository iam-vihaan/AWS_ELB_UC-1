
variable "name" {
  description = "Target group name"
  type        = string
  default     = "example-tg" # Example default value
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "target_id" {
  description = "Target ID (instance ID)"
  type        = string
}
