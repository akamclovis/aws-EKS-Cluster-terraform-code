variable "state_bucket_name" {
  description = "Globally unique S3 bucket name for Terraform remote state."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.state_bucket_name))
    error_message = "state_bucket_name must be a valid S3 bucket name between 3 and 63 characters."
  }
}

variable "aws_region" {
  description = "AWS region where the Terraform state bucket will be created."
  type        = string
  default     = "us-east-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]+$", var.aws_region))
    error_message = "aws_region must be a valid AWS region identifier such as us-east-1."
  }
}

variable "project_name" {
  description = "Project name used for state bucket tagging."
  type        = string
  default     = "eks-platform"
}

variable "environment" {
  description = "Environment label used for state bucket tagging."
  type        = string
  default     = "bootstrap"
}

variable "owner" {
  description = "Owner tag value for the state bucket."
  type        = string
  default     = "DevOps-Team"
}

variable "additional_tags" {
  description = "Additional tags to merge with standard tags. Standard tags take precedence."
  type        = map(string)
  default     = {}
}
