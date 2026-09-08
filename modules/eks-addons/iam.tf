data "aws_partition" "current" {}

data "aws_iam_policy_document" "vpc_cni_pod_identity_assume_role" {
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

data "aws_iam_policy_document" "ebs_csi_pod_identity_assume_role" {
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

resource "aws_iam_role" "vpc_cni" {
  name               = "${var.name_prefix}-vpc-cni-role"
  assume_role_policy = data.aws_iam_policy_document.vpc_cni_pod_identity_assume_role.json

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-vpc-cni-role"
  })
}

resource "aws_iam_role_policy_attachment" "vpc_cni" {
  role       = aws_iam_role.vpc_cni.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_eks_pod_identity_association" "vpc_cni" {
  cluster_name    = var.cluster_name
  namespace       = "kube-system"
  service_account = "aws-node"
  role_arn        = aws_iam_role.vpc_cni.arn

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-vpc-cni"
  })

  depends_on = [
    aws_eks_addon.pod_identity_agent,
    aws_iam_role_policy_attachment.vpc_cni
  ]
}

resource "aws_iam_role" "ebs_csi" {
  name               = "${var.name_prefix}-ebs-csi-role"
  assume_role_policy = data.aws_iam_policy_document.ebs_csi_pod_identity_assume_role.json

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-ebs-csi-role"
  })
}

resource "aws_iam_role_policy_attachment" "ebs_csi" {
  role       = aws_iam_role.ebs_csi.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicyV2"
}

resource "aws_eks_pod_identity_association" "ebs_csi" {
  cluster_name    = var.cluster_name
  namespace       = "kube-system"
  service_account = "ebs-csi-controller-sa"
  role_arn        = aws_iam_role.ebs_csi.arn

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-ebs-csi"
  })

  depends_on = [
    aws_eks_addon.pod_identity_agent,
    aws_iam_role_policy_attachment.ebs_csi
  ]
}
