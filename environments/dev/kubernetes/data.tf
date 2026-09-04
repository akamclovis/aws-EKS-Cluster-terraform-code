data "terraform_remote_state" "core" {
  backend = "s3"

  config = {
    bucket       = var.state_bucket_name
    key          = var.core_state_key
    region       = var.state_bucket_region
    use_lockfile = true
  }
}

data "terraform_remote_state" "platform" {
  backend = "s3"

  config = {
    bucket       = var.state_bucket_name
    key          = var.platform_state_key
    region       = var.state_bucket_region
    use_lockfile = true
  }
}

data "aws_eks_cluster" "current" {
  name = data.terraform_remote_state.core.outputs.cluster_name
}

data "aws_route53_zone" "external_dns" {
  name         = var.route53_zone_name
  private_zone = false
}
