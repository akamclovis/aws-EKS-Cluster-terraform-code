resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn
  version  = var.cluster_version

  enabled_cluster_log_types = var.enabled_cluster_log_types

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = false
  }

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs
  }

  tags = merge(var.tags, {
    Name = var.cluster_name
  })

  depends_on = [
    aws_iam_role_policy_attachment.cluster
  ]
}

resource "aws_eks_access_entry" "cluster_admin" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = var.cluster_admin_principal_arn
  type          = "STANDARD"

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-cluster-admin"
  })
}

resource "aws_eks_access_policy_association" "cluster_admin" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = aws_eks_access_entry.cluster_admin.principal_arn
  policy_arn    = "arn:${data.aws_partition.current.partition}:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_node_group" "general" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.name_prefix}-general"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.private_subnet_ids

  ami_type       = "AL2023_x86_64_STANDARD"
  capacity_type  = var.node_capacity_type
  disk_size      = var.node_disk_size
  instance_types = var.node_instance_types
  labels         = var.node_labels
  version        = aws_eks_cluster.this.version

  scaling_config {
    min_size     = var.node_min_size
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
  }

  update_config {
    max_unavailable = 1
  }

  dynamic "taint" {
    for_each = var.node_taints

    content {
      key    = taint.value.key
      value  = try(taint.value.value, null)
      effect = taint.value.effect
    }
  }

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-general"
  })

  depends_on = [
    aws_eks_access_policy_association.cluster_admin,
    aws_iam_role_policy_attachment.node_worker,
    aws_iam_role_policy_attachment.node_ecr_pull,
    aws_iam_role_policy_attachment.node_cni_temporary
  ]
}
