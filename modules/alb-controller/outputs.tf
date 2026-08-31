output "alb_controller_role_arn" {
  description = "ARN of the IAM role used by AWS Load Balancer Controller through EKS Pod Identity."
  value       = aws_iam_role.this.arn
}

output "alb_controller_policy_arn" {
  description = "ARN of the IAM policy for AWS Load Balancer Controller."
  value       = aws_iam_policy.this.arn
}

output "alb_controller_pod_identity_association_id" {
  description = "ID of the AWS Load Balancer Controller EKS Pod Identity association."
  value       = aws_eks_pod_identity_association.this.association_id
}
