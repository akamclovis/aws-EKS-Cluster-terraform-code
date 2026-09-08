locals {
  name_prefix = "${var.project_name}-${var.environment}"

  labels = {
    environment = var.environment
    project     = var.project_name
    managed-by  = "terraform"
    cluster     = data.terraform_remote_state.core.outputs.cluster_name
  }
}
