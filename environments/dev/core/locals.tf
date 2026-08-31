locals {
  name_prefix = "${var.project_name}-${var.environment}"

  standard_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = var.owner
  }

  common_tags = merge(var.additional_tags, local.standard_tags)
}
