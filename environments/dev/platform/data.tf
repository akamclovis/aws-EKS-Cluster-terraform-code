data "terraform_remote_state" "core" {
  backend = "s3"

  config = {
    bucket       = var.state_bucket_name
    key          = var.core_state_key
    region       = var.state_bucket_region
    use_lockfile = true
  }
}

data "aws_route53_zone" "external_dns" {
  name         = var.route53_zone_name
  private_zone = false
}
