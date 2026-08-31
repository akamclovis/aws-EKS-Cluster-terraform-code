output "vpc_cni_role_arn" {
  description = "ARN of the IAM role used by the VPC CNI through EKS Pod Identity."
  value       = aws_iam_role.vpc_cni.arn
}

output "vpc_cni_pod_identity_association_id" {
  description = "ID of the VPC CNI EKS Pod Identity association."
  value       = aws_eks_pod_identity_association.vpc_cni.association_id
}

output "managed_addon_versions" {
  description = "EKS managed add-on versions selected or pinned for the cluster."
  value = {
    vpc_cni                = aws_eks_addon.vpc_cni.addon_version
    coredns                = aws_eks_addon.coredns.addon_version
    kube_proxy             = aws_eks_addon.kube_proxy.addon_version
    eks_pod_identity_agent = aws_eks_addon.pod_identity_agent.addon_version
  }
}
