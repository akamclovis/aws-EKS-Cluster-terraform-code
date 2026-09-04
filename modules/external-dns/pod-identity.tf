resource "aws_eks_pod_identity_association" "this" {
  cluster_name    = var.cluster_name
  namespace       = "external-dns"
  service_account = "external-dns"
  role_arn        = aws_iam_role.this.arn

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-external-dns"
  })

  depends_on = [
    aws_iam_role_policy_attachment.this
  ]
}
