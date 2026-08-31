data "aws_iam_policy_document" "pod_identity_assume_role" {
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

resource "aws_iam_policy" "this" {
  name        = "${var.name_prefix}-aws-load-balancer-controller"
  description = "IAM policy for AWS Load Balancer Controller on ${var.cluster_name}."
  policy      = file("${path.module}/iam-policy.json")

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-aws-load-balancer-controller"
  })
}

resource "aws_iam_role" "this" {
  name               = "${var.name_prefix}-alb-controller-role"
  assume_role_policy = data.aws_iam_policy_document.pod_identity_assume_role.json

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-alb-controller-role"
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
