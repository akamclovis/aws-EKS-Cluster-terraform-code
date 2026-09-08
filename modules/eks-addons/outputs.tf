output "vpc_cni_role_arn" {
  description = "ARN of the IAM role used by the VPC CNI through EKS Pod Identity."
  value       = aws_iam_role.vpc_cni.arn
}

output "vpc_cni_pod_identity_association_id" {
  description = "ID of the VPC CNI EKS Pod Identity association."
  value       = aws_eks_pod_identity_association.vpc_cni.association_id
}

output "ebs_csi_role_arn" {
  description = "ARN of the IAM role used by the EBS CSI driver through EKS Pod Identity."
  value       = aws_iam_role.ebs_csi.arn
}

output "ebs_csi_pod_identity_association_id" {
  description = "ID of the EBS CSI EKS Pod Identity association."
  value       = aws_eks_pod_identity_association.ebs_csi.association_id
}

output "managed_addon_versions" {
  description = "EKS managed add-on versions selected or pinned for the cluster."
  value = {
    vpc_cni                = aws_eks_addon.vpc_cni.addon_version
    coredns                = aws_eks_addon.coredns.addon_version
    kube_proxy             = aws_eks_addon.kube_proxy.addon_version
    eks_pod_identity_agent = aws_eks_addon.pod_identity_agent.addon_version
    aws_ebs_csi_driver     = aws_eks_addon.ebs_csi.addon_version
  }
}
