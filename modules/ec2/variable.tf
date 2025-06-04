variable "env" {}
variable "ami_name" {
  description = "AMI name for EC2 instances"
  type        = string
  default     = "ami-0953476d60561c955" # Amazon Linux 2
}

variable "instance_type" {}
variable "key_name" {}
variable "private_subnets" {}
variable "sg_id" {}
variable "vpc_name" {}
#variable elb_listener {}
variable "iam_instance_profile" {
  description = "IAM instance profile for EC2 instances"
  type        = string
  default     = ""
}
#variable elb_listener_public {}
variable "project_name" {}

variable "associate_public_ip_address" {
  description = "Associate public IP address with EC2 instances"
  type        = bool
  default     = false

}

variable "user_data" {
  description = "user_data scripts"
  type        = string
  default     = ""

}
