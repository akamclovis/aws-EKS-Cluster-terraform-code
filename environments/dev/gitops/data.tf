data "terraform_remote_state" "core" {
  backend = "s3"

  config = {
    bucket       = var.state_bucket_name
    key          = var.core_state_key
    region       = var.state_bucket_region
    use_lockfile = true
  }
}

data "aws_eks_cluster" "current" {
  name = data.terraform_remote_state.core.outputs.cluster_name
}
