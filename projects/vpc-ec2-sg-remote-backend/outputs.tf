output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id

}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnet_ids

}
output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.vpc.private_subnet_ids

}

output "nat_gateway_ids" {
  description = "The IDs of the NAT gateways"
  value       = module.vpc.nat_gateway_ids

}

output "instance_id" {
  value       = module.ec2.instance_id
  description = "The ID of the EC2 instance."

}

output "instance_public_ip" {
  value       = module.ec2.instance_public_ip
  description = "The public IP address of the EC2 instance."

}