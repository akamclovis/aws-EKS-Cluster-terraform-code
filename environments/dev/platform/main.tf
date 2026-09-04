module "eks_addons" {
  source = "../../../modules/eks-addons"

  name_prefix                      = local.name_prefix
  cluster_name                     = data.terraform_remote_state.core.outputs.cluster_name
  cluster_version                  = data.terraform_remote_state.core.outputs.cluster_version
  vpc_cni_addon_version            = var.vpc_cni_addon_version
  coredns_addon_version            = var.coredns_addon_version
  kube_proxy_addon_version         = var.kube_proxy_addon_version
  pod_identity_agent_addon_version = var.pod_identity_agent_addon_version
  tags                             = local.common_tags
}

module "efs" {
  source = "../../../modules/efs"

  name_prefix               = local.name_prefix
  vpc_id                    = data.terraform_remote_state.core.outputs.vpc_id
  vpc_cidr_block            = data.terraform_remote_state.core.outputs.vpc_cidr
  private_subnet_ids_by_az  = data.terraform_remote_state.core.outputs.private_subnet_ids_by_az
  cluster_name              = data.terraform_remote_state.core.outputs.cluster_name
  cluster_version           = data.terraform_remote_state.core.outputs.cluster_version
  cluster_security_group_id = data.terraform_remote_state.core.outputs.cluster_security_group_id
  efs_csi_addon_version     = var.efs_csi_addon_version
  tags                      = local.common_tags
}

module "alb_controller" {
  source = "../../../modules/alb-controller"

  name_prefix  = local.name_prefix
  cluster_name = data.terraform_remote_state.core.outputs.cluster_name
  tags         = local.common_tags

  depends_on = [
    module.eks_addons
  ]
}

module "external_dns" {
  source = "../../../modules/external-dns"

  name_prefix     = local.name_prefix
  cluster_name    = data.terraform_remote_state.core.outputs.cluster_name
  route53_zone_id = data.aws_route53_zone.external_dns.zone_id
  tags            = local.common_tags
}
