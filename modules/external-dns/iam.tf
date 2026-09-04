data "aws_partition" "current" {}

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

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/kubernetes-namespace"
      values   = ["external-dns"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/kubernetes-service-account"
      values   = ["external-dns"]
    }
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    sid    = "AllowHostedZoneChanges"
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets"
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:route53:::hostedzone/${var.route53_zone_id}"
    ]
  }

  statement {
    sid    = "AllowHostedZoneReads"
    effect = "Allow"
    actions = [
      "route53:GetHostedZone",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource",
      "route53:ListTagsForResources"
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:route53:::hostedzone/${var.route53_zone_id}"
    ]
  }

  statement {
    sid    = "AllowRoute53Discovery"
    effect = "Allow"
    actions = [
      "route53:ListHostedZones",
      "route53:ListHostedZonesByName"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "this" {
  name        = "${var.name_prefix}-external-dns"
  description = "IAM policy for ExternalDNS on ${var.cluster_name}."
  policy      = data.aws_iam_policy_document.this.json

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-external-dns"
  })
}

resource "aws_iam_role" "this" {
  name               = "${var.name_prefix}-external-dns-role"
  assume_role_policy = data.aws_iam_policy_document.pod_identity_assume_role.json

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-external-dns-role"
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
