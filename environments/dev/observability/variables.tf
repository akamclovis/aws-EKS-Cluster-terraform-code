variable "project_name" {
  description = "Short project identifier used for naming and observability metadata."
  type        = string
  default     = "eks-platform"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"
}

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

variable "monitoring_namespace" {
  description = "Namespace for observability components."
  type        = string
  default     = "monitoring"
}

variable "kube_prometheus_stack_chart_version" {
  description = "Pinned kube-prometheus-stack Helm chart version."
  type        = string
  default     = "89.2.0"
}

variable "loki_chart_version" {
  description = "Pinned Grafana Community Loki Helm chart version."
  type        = string
  default     = "18.7.6"
}

variable "alloy_chart_version" {
  description = "Pinned Grafana Alloy Helm chart version."
  type        = string
  default     = "1.12.1"
}

variable "grafana_admin_password" {
  description = "Optional local-only Grafana admin password for later phases. Do not commit this value."
  type        = string
  default     = null
  sensitive   = true
}
