output "homepage_instance_id" {
  description = "ID of the homepage EC2 instance"
  value       = module.homepage_instance.instance_id
}

output "images_instance_id" {
  description = "IDs of all images instance"
  value       = module.images_instance.instance_id
}

output "register_instance_id" {
  description = "IDs of all register instance"
  value       = module.register_instance.instance_id
}

output "homepage_instance_private_ip" {
  description = "IDs of homepage instance private ip"
  value       = module.homepage_instance.private_ip
}

output "images_instance_private_ip" {
  description = "IDs of all images instance private ip"
  value       = module.images_instance.private_ip
}

output "register_instance_private_ip" {
  description = "IDs of all register instance private ip"
  value       = module.register_instance.private_ip
}


output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.network.public_subnets_id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.network.private_subnets_id
}
