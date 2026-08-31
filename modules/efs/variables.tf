variable "name_prefix" {
  description = "Prefix used for naming EFS resources."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,48}[a-z0-9]$", var.name_prefix))
    error_message = "name_prefix must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "vpc_id" {
  description = "VPC ID where EFS mount targets will be created."
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block used for optional diagnostics and validation."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr_block))
    error_message = "vpc_cidr_block must be a valid IPv4 CIDR block."
  }
}

variable "private_subnet_ids_by_az" {
  description = "Private subnet IDs keyed by Availability Zone."
  type        = map(string)
}

variable "cluster_name" {
  description = "Name of the EKS cluster that will use the EFS CSI driver."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes minor version used for EKS add-on version discovery."
  type        = string
}

variable "cluster_security_group_id" {
  description = "EKS cluster security group ID used as the source for NFS traffic to EFS."
  type        = string
}

variable "efs_csi_addon_version" {
  description = "Approved EFS CSI add-on version. When null, the EKS-recommended compatible version is discovered temporarily."
  type        = string
  default     = null
}

variable "efs_encrypted" {
  description = "Whether the EFS filesystem is encrypted at rest."
  type        = bool
  default     = true

  validation {
    condition     = var.efs_encrypted
    error_message = "EFS encryption must remain enabled."
  }
}

variable "efs_performance_mode" {
  description = "EFS performance mode."
  type        = string
  default     = "generalPurpose"

  validation {
    condition     = contains(["generalPurpose", "maxIO"], var.efs_performance_mode)
    error_message = "efs_performance_mode must be generalPurpose or maxIO."
  }
}

variable "efs_throughput_mode" {
  description = "EFS throughput mode."
  type        = string
  default     = "bursting"

  validation {
    condition     = contains(["bursting", "elastic", "provisioned"], var.efs_throughput_mode)
    error_message = "efs_throughput_mode must be bursting, elastic, or provisioned."
  }
}

variable "tags" {
  description = "Common tags applied to EFS resources."
  type        = map(string)
  default     = {}
}
