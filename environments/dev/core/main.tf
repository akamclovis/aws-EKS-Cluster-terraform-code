module "networking" {
  source = "../../../modules/networking"

  name_prefix          = local.name_prefix
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  single_nat_gateway   = var.single_nat_gateway
  tags                 = local.common_tags
}

module "eks" {
  source = "../../../modules/eks"

  name_prefix                          = local.name_prefix
  cluster_name                         = coalesce(var.cluster_name, local.name_prefix)
  cluster_version                      = var.cluster_version
  vpc_id                               = module.networking.vpc_id
  private_subnet_ids                   = module.networking.private_subnet_ids
  cluster_endpoint_private_access      = var.cluster_endpoint_private_access
  cluster_endpoint_public_access       = var.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  cluster_admin_principal_arn          = var.cluster_admin_principal_arn
  node_instance_types                  = var.node_instance_types
  node_min_size                        = var.node_min_size
  node_desired_size                    = var.node_desired_size
  node_max_size                        = var.node_max_size
  node_disk_size                       = var.node_disk_size
  node_capacity_type                   = var.node_capacity_type
  node_labels                          = var.node_labels
  node_taints                          = var.node_taints
  attach_cni_policy_to_node_role       = var.attach_cni_policy_to_node_role
  tags                                 = local.common_tags

  depends_on = [module.networking]
}
