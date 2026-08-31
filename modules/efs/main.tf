resource "aws_efs_file_system" "this" {
  creation_token   = "${var.name_prefix}-efs"
  encrypted        = var.efs_encrypted
  performance_mode = var.efs_performance_mode
  throughput_mode  = var.efs_throughput_mode

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-efs"
  })
}

resource "aws_security_group" "efs" {
  name        = "${var.name_prefix}-efs-sg"
  description = "Allow NFS from EKS nodes to EFS"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-efs-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "nfs_from_eks" {
  security_group_id            = aws_security_group.efs.id
  referenced_security_group_id = var.cluster_security_group_id
  from_port                    = 2049
  ip_protocol                  = "tcp"
  to_port                      = 2049

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-efs-nfs-from-eks"
  })
}

resource "aws_efs_mount_target" "this" {
  for_each = var.private_subnet_ids_by_az

  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = each.value
  security_groups = [aws_security_group.efs.id]
}

data "aws_eks_addon_version" "efs_csi" {
  addon_name         = "aws-efs-csi-driver"
  kubernetes_version = var.cluster_version
}

resource "aws_eks_addon" "efs_csi" {
  cluster_name  = var.cluster_name
  addon_name    = "aws-efs-csi-driver"
  addon_version = coalesce(var.efs_csi_addon_version, data.aws_eks_addon_version.efs_csi.version)

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-aws-efs-csi-driver"
  })

  depends_on = [
    aws_eks_pod_identity_association.efs_csi,
    aws_efs_mount_target.this
  ]
}
