locals {
  core_addons = toset([
    "vpc-cni",
    "coredns",
    "kube-proxy",
    "eks-pod-identity-agent"
  ])
}

data "aws_eks_addon_version" "core" {
  for_each = local.core_addons

  addon_name         = each.key
  kubernetes_version = var.cluster_version
}

resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name  = var.cluster_name
  addon_name    = "eks-pod-identity-agent"
  addon_version = coalesce(var.pod_identity_agent_addon_version, data.aws_eks_addon_version.core["eks-pod-identity-agent"].version)

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-eks-pod-identity-agent"
  })
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name  = var.cluster_name
  addon_name    = "vpc-cni"
  addon_version = coalesce(var.vpc_cni_addon_version, data.aws_eks_addon_version.core["vpc-cni"].version)

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-vpc-cni"
  })

  depends_on = [
    aws_eks_pod_identity_association.vpc_cni
  ]
}

resource "aws_eks_addon" "coredns" {
  cluster_name  = var.cluster_name
  addon_name    = "coredns"
  addon_version = coalesce(var.coredns_addon_version, data.aws_eks_addon_version.core["coredns"].version)

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-coredns"
  })
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name  = var.cluster_name
  addon_name    = "kube-proxy"
  addon_version = coalesce(var.kube_proxy_addon_version, data.aws_eks_addon_version.core["kube-proxy"].version)

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-kube-proxy"
  })
}

resource "aws_eks_addon" "ebs_csi" {
  cluster_name  = var.cluster_name
  addon_name    = "aws-ebs-csi-driver"
  addon_version = var.ebs_csi_addon_version

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-aws-ebs-csi-driver"
  })

  depends_on = [
    aws_eks_pod_identity_association.ebs_csi
  ]
}
