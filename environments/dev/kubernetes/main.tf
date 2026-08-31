resource "kubernetes_storage_class_v1" "efs" {
  metadata {
    name = var.efs_storage_class_name
  }

  storage_provisioner    = "efs.csi.aws.com"
  reclaim_policy         = "Delete"
  volume_binding_mode    = "Immediate"
  allow_volume_expansion = true
  mount_options          = ["tls"]

  parameters = {
    provisioningMode = "efs-ap"
    fileSystemId     = data.terraform_remote_state.platform.outputs.efs_file_system_id
    directoryPerms   = "700"
    gidRangeStart    = "50000"
    gidRangeEnd      = "7000000"
    basePath         = "/dynamic_provisioning"
  }
}

resource "kubernetes_service_account_v1" "aws_load_balancer_controller" {
  metadata {
    name      = var.alb_controller_service_account_name
    namespace = "kube-system"
  }
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = var.alb_controller_chart_version
  namespace  = "kube-system"

  values = [
    yamlencode({
      clusterName = data.terraform_remote_state.core.outputs.cluster_name
      region      = data.terraform_remote_state.core.outputs.aws_region
      vpcId       = data.terraform_remote_state.core.outputs.vpc_id
      image = {
        tag = var.alb_controller_image_tag
      }
      serviceAccount = {
        create = false
        name   = kubernetes_service_account_v1.aws_load_balancer_controller.metadata[0].name
      }
      replicaCount = 2
    })
  ]

  depends_on = [
    kubernetes_service_account_v1.aws_load_balancer_controller
  ]
}
