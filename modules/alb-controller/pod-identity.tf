resource "aws_eks_pod_identity_association" "this" {
  cluster_name    = var.cluster_name
  namespace       = "kube-system"
  service_account = "aws-load-balancer-controller"
  role_arn        = aws_iam_role.this.arn

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-aws-load-balancer-controller"
  })

  depends_on = [
    aws_iam_role_policy_attachment.this
  ]
}
