terraform {
  backend "s3" {
    bucket       = "eks-platform-terraform-state-945788750616"
    key          = "eks-platform/dev/gitops.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
