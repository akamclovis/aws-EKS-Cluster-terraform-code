output "aws_region" {
  description = "AWS region for the dev core environment."
  value       = var.aws_region
}

output "vpc_id" {
  description = "ID of the networking VPC."
  value       = module.networking.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the networking VPC."
  value       = module.networking.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "Public subnet IDs for internet-facing load balancers."
  value       = module.networking.public_subnet_ids
}

output "public_subnet_ids_by_az" {
  description = "Public subnet IDs keyed by Availability Zone."
  value       = module.networking.public_subnet_ids_by_az
}

output "private_subnet_ids" {
  description = "Private subnet IDs for EKS managed node groups."
  value       = module.networking.private_subnet_ids
}

output "private_subnet_ids_by_az" {
  description = "Private subnet IDs keyed by Availability Zone."
  value       = module.networking.private_subnet_ids_by_az
}

output "cluster_name" {
  description = "Name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "cluster_arn" {
  description = "ARN of the EKS cluster."
  value       = module.eks.cluster_arn
}

output "cluster_endpoint" {
  description = "Endpoint URL for the EKS Kubernetes API server."
  value       = module.eks.cluster_endpoint
}

output "cluster_version" {
  description = "Kubernetes version of the EKS cluster."
  value       = module.eks.cluster_version
}

output "cluster_security_group_id" {
  description = "ID of the EKS-created cluster security group."
  value       = module.eks.cluster_security_group_id
}

output "node_security_group_id" {
  description = "Node security group ID if directly available from the managed node group."
  value       = module.eks.node_security_group_id
}

output "node_role_name" {
  description = "Name of the EKS managed node IAM role."
  value       = module.eks.node_role_name
}

output "node_role_arn" {
  description = "ARN of the EKS managed node IAM role."
  value       = module.eks.node_role_arn
}
