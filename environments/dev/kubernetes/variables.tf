variable "aws_region" {
  description = "AWS region where the EKS cluster runs."
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  description = "S3 bucket name that stores Terraform remote states."
  type        = string
  default     = "eks-platform-terraform-state-945788750616"
}

variable "state_bucket_region" {
  description = "AWS region for the Terraform remote state bucket."
  type        = string
  default     = "us-east-1"
}

variable "core_state_key" {
  description = "S3 key for the dev core Terraform state."
  type        = string
  default     = "eks-platform/dev/core.tfstate"
}

variable "platform_state_key" {
  description = "S3 key for the dev platform Terraform state."
  type        = string
  default     = "eks-platform/dev/platform.tfstate"
}

variable "efs_storage_class_name" {
  description = "Kubernetes StorageClass name for dynamic EFS access point provisioning."
  type        = string
  default     = "efs-sc"
}

variable "alb_controller_service_account_name" {
  description = "Kubernetes ServiceAccount name for AWS Load Balancer Controller."
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "alb_controller_chart_version" {
  description = "Pinned AWS Load Balancer Controller Helm chart version."
  type        = string
  default     = "3.5.0"
}

variable "alb_controller_image_tag" {
  description = "Pinned AWS Load Balancer Controller application image tag."
  type        = string
  default     = "v3.5.0"
}
