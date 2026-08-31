data "aws_partition" "current" {}

data "aws_iam_policy_document" "efs_csi_pod_identity_assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "efs_csi" {
  name               = "${var.name_prefix}-efs-csi-role"
  assume_role_policy = data.aws_iam_policy_document.efs_csi_pod_identity_assume_role.json

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-efs-csi-role"
  })
}

resource "aws_iam_role_policy_attachment" "efs_csi" {
  role       = aws_iam_role.efs_csi.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
}

resource "aws_eks_pod_identity_association" "efs_csi" {
  cluster_name    = var.cluster_name
  namespace       = "kube-system"
  service_account = "efs-csi-controller-sa"
  role_arn        = aws_iam_role.efs_csi.arn

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-efs-csi"
  })

  depends_on = [
    aws_iam_role_policy_attachment.efs_csi
  ]
}
