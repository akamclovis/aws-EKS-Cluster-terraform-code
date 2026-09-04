output "vpc_cni_role_arn" {
  description = "ARN of the IAM role used by the VPC CNI through EKS Pod Identity."
  value       = module.eks_addons.vpc_cni_role_arn
}

output "vpc_cni_pod_identity_association_id" {
  description = "ID of the VPC CNI EKS Pod Identity association."
  value       = module.eks_addons.vpc_cni_pod_identity_association_id
}

output "managed_addon_versions" {
  description = "EKS managed add-on versions selected or pinned for core add-ons."
  value       = module.eks_addons.managed_addon_versions
}

output "efs_file_system_id" {
  description = "ID of the EFS filesystem."
  value       = module.efs.efs_file_system_id
}

output "efs_file_system_arn" {
  description = "ARN of the EFS filesystem."
  value       = module.efs.efs_file_system_arn
}

output "efs_security_group_id" {
  description = "ID of the EFS security group."
  value       = module.efs.efs_security_group_id
}

output "efs_mount_target_ids" {
  description = "IDs of the EFS mount targets."
  value       = module.efs.efs_mount_target_ids
}

output "efs_csi_role_arn" {
  description = "ARN of the IAM role used by the EFS CSI driver through EKS Pod Identity."
  value       = module.efs.efs_csi_role_arn
}

output "efs_csi_pod_identity_association_id" {
  description = "ID of the EFS CSI EKS Pod Identity association."
  value       = module.efs.efs_csi_pod_identity_association_id
}

output "efs_csi_addon_version" {
  description = "EKS-managed EFS CSI driver add-on version selected or pinned for the cluster version."
  value       = module.efs.efs_csi_addon_version
}

output "alb_controller_role_arn" {
  description = "ARN of the IAM role used by AWS Load Balancer Controller through EKS Pod Identity."
  value       = module.alb_controller.alb_controller_role_arn
}

output "alb_controller_policy_arn" {
  description = "ARN of the IAM policy for AWS Load Balancer Controller."
  value       = module.alb_controller.alb_controller_policy_arn
}

output "alb_controller_pod_identity_association_id" {
  description = "ID of the AWS Load Balancer Controller EKS Pod Identity association."
  value       = module.alb_controller.alb_controller_pod_identity_association_id
}

output "external_dns_role_arn" {
  description = "ARN of the IAM role used by ExternalDNS through EKS Pod Identity."
  value       = module.external_dns.external_dns_role_arn
}

output "external_dns_policy_arn" {
  description = "ARN of the IAM policy for ExternalDNS."
  value       = module.external_dns.external_dns_policy_arn
}

output "external_dns_pod_identity_association_id" {
  description = "ID of the ExternalDNS EKS Pod Identity association."
  value       = module.external_dns.external_dns_pod_identity_association_id
}
