output "external_dns_role_arn" {
  description = "ARN of the IAM role used by ExternalDNS through EKS Pod Identity."
  value       = aws_iam_role.this.arn
}

output "external_dns_policy_arn" {
  description = "ARN of the IAM policy for ExternalDNS."
  value       = aws_iam_policy.this.arn
}

output "external_dns_pod_identity_association_id" {
  description = "ID of the ExternalDNS EKS Pod Identity association."
  value       = aws_eks_pod_identity_association.this.association_id
}
