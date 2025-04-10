output "security_group_id" {
  value = module.sg.security_group_id

}

output "vpc_id" {
  value = module.vpc.vpc_id

}

output "eks_cluster_name" {
  value = module.eks.cluster_id


}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint

}

