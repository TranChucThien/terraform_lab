# provider "aws" {
#   region = "us-east-2"

# }


terraform {
  

  backend "s3" {
  bucket         = "chucthien-backend-s3"
  key            = "dev/terraform.tfstate"
  region         = "us-east-2"
  use_lockfile   = true
  encrypt = true
}

  required_version = ">= 1.0.0"
}
module "vpc" {
  source = "./modules/vpc"
  name   = "tct-vpc"

}

module "ec2" {
  source   = "./modules/ec2-sg" # Path to the module directory
  key_name = "tct-key-pair"
  ec2_name = "tct-ec2-instance"   # Example tag name for EC2 instance, can be overridden
  key_path = "./tct-key-pair.pem" # Path to the private key file
  ingress_rules = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },   # SSH
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },   # HTTP
    { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }, # HTTPS
  ]
  sg_description = "SG with SSH and HTTP/HTTPS access"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = element(module.vpc.public_subnet_ids, 0) # Use the first public subnet
  # provisioner_commands = [
  #   ""
  # ]
}

