output "cluster_name" {
  description = "Name of the EKS cluster."
  value       = aws_eks_cluster.this.name
}

output "cluster_arn" {
  description = "ARN of the EKS cluster."
  value       = aws_eks_cluster.this.arn
}

output "cluster_endpoint" {
  description = "Endpoint URL for the EKS Kubernetes API server."
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_version" {
  description = "Kubernetes version of the EKS cluster."
  value       = aws_eks_cluster.this.version
}

output "cluster_security_group_id" {
  description = "ID of the EKS-created cluster security group."
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}

output "node_group_name" {
  description = "Name of the EKS managed node group."
  value       = aws_eks_node_group.general.node_group_name
}

output "node_group_arn" {
  description = "ARN of the EKS managed node group."
  value       = aws_eks_node_group.general.arn
}

output "node_role_arn" {
  description = "ARN of the IAM role used by EKS managed node group instances."
  value       = aws_iam_role.node.arn
}

output "node_role_name" {
  description = "Name of the IAM role used by EKS managed node group instances."
  value       = aws_iam_role.node.name
}

output "node_security_group_id" {
  description = "Node security group ID if one is created directly by the managed node group."
  value       = try(aws_eks_node_group.general.resources[0].remote_access_security_group_id, null)
}

output "cluster_role_arn" {
  description = "ARN of the IAM role used by the EKS control plane."
  value       = aws_iam_role.cluster.arn
}
