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
