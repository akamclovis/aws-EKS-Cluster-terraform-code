output "efs_file_system_id" {
  description = "ID of the EFS filesystem."
  value       = aws_efs_file_system.this.id
}

output "efs_file_system_arn" {
  description = "ARN of the EFS filesystem."
  value       = aws_efs_file_system.this.arn
}

output "efs_security_group_id" {
  description = "ID of the EFS security group."
  value       = aws_security_group.efs.id
}

output "efs_mount_target_ids" {
  description = "IDs of the EFS mount targets."
  value       = values(aws_efs_mount_target.this)[*].id
}

output "efs_csi_role_arn" {
  description = "ARN of the IAM role used by the EFS CSI driver through EKS Pod Identity."
  value       = aws_iam_role.efs_csi.arn
}

output "efs_csi_pod_identity_association_id" {
  description = "ID of the EFS CSI EKS Pod Identity association."
  value       = aws_eks_pod_identity_association.efs_csi.association_id
}

output "efs_csi_addon_version" {
  description = "EKS-managed EFS CSI driver add-on version selected for the cluster version."
  value       = aws_eks_addon.efs_csi.addon_version
}
