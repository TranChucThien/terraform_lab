provider "aws" {
  region = "us-east-2"

}

module "vpc" {
  source = "../../projects/vpc-ec2-sg/modules/vpc"
  name   = "${var.project_name}-vpc"

}

module "sg" {
  source         = "../../securitygroup"
  sg_name        = "${var.project_name}-sg"
  sg_description = "Security group for EKS cluster"
  vpc_id         = module.vpc.vpc_id
  ingress_rules = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },   # SSH
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },   # HTTP
    { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }, # HTTPS
  ]

}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"
  cluster_name = "${var.project_name}-eks"
  cluster_version = "1.31"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
  control_plane_subnet_ids = module.vpc.public_subnet_ids
  cluster_endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true
  bootstrap_self_managed_addons = false
  cluster_addons = {
    coredns                = {
      enabled = true
      version = "v1.11.4-eksbuild.2"
      resolve_conflicts = "OVERWRITE"
    }

    kube-proxy             = {
      enabled = true
      version = "v1.32.0-eksbuild.2"
      resolve_conflicts = "OVERWRITE"
    }
    vpc-cni                = {
      enabled = true
      version = "v1.19.2-eksbuild.1"

    }
    
  }
  eks_managed_node_groups = {
    example = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t2.micro"]
      min_size       = var.min_size
      max_size       = var.max_size
      desired_size   = var.desired_size
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
  depends_on = [module.sg]
  
}

