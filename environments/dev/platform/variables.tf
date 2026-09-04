variable "project_name" {
  description = "Short project identifier used for naming and tagging AWS resources."
  type        = string
  default     = "eks-platform"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region where platform resources are deployed."
  type        = string
  default     = "us-east-1"
}

variable "owner" {
  description = "Owner tag value used to identify the team responsible for the environment."
  type        = string
  default     = "DevOps-Team"
}

variable "additional_tags" {
  description = "Additional tags to merge with standard tags."
  type        = map(string)
  default     = {}
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

variable "vpc_cni_addon_version" {
  description = "Approved VPC CNI add-on version. Set before the next infrastructure rebuild."
  type        = string
  default     = null
}

variable "coredns_addon_version" {
  description = "Approved CoreDNS add-on version. Set before the next infrastructure rebuild."
  type        = string
  default     = null
}

variable "kube_proxy_addon_version" {
  description = "Approved kube-proxy add-on version. Set before the next infrastructure rebuild."
  type        = string
  default     = null
}

variable "pod_identity_agent_addon_version" {
  description = "Approved EKS Pod Identity Agent add-on version. Set before the next infrastructure rebuild."
  type        = string
  default     = null
}

variable "efs_csi_addon_version" {
  description = "Approved EFS CSI add-on version. Set before the next infrastructure rebuild."
  type        = string
  default     = null
}

variable "route53_zone_name" {
  description = "Public Route53 hosted zone name ExternalDNS is allowed to manage. Set only in ignored local terraform.tfvars."
  type        = string
}
