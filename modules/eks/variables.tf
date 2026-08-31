variable "name_prefix" {
  description = "Prefix used for naming EKS resources."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,48}[a-z0-9]$", var.name_prefix))
    error_message = "name_prefix must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9][A-Za-z0-9_-]{0,99}$", var.cluster_name))
    error_message = "cluster_name must start with an alphanumeric character and contain only letters, numbers, hyphens, and underscores."
  }
}

variable "cluster_version" {
  description = "Kubernetes minor version for the EKS cluster."
  type        = string

  validation {
    condition     = can(regex("^1\\.\\d+$", var.cluster_version))
    error_message = "cluster_version must be a Kubernetes minor version such as 1.35."
  }
}

variable "vpc_id" {
  description = "VPC ID where the EKS cluster will run."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the EKS control plane ENIs and managed node group."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "private_subnet_ids must include at least two private subnets."
  }
}

variable "cluster_endpoint_private_access" {
  description = "Whether the EKS private API endpoint is enabled."
  type        = bool
}

variable "cluster_endpoint_public_access" {
  description = "Whether the EKS public API endpoint is enabled."
  type        = bool
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "CIDR blocks allowed to access the public EKS API endpoint."
  type        = list(string)

  validation {
    condition     = alltrue([for cidr in var.cluster_endpoint_public_access_cidrs : can(cidrnetmask(cidr))])
    error_message = "Every cluster endpoint public access CIDR must be a valid IPv4 CIDR block."
  }

  validation {
    condition     = !var.cluster_endpoint_public_access || length(var.cluster_endpoint_public_access_cidrs) > 0
    error_message = "cluster_endpoint_public_access_cidrs must not be empty when public endpoint access is enabled."
  }

  validation {
    condition     = !contains(var.cluster_endpoint_public_access_cidrs, "0.0.0.0/0")
    error_message = "Do not use 0.0.0.0/0 for the EKS public API endpoint."
  }
}

variable "cluster_admin_principal_arn" {
  description = "IAM role or user ARN granted initial EKS cluster administrator access. Do not use an STS assumed-role session ARN."
  type        = string

  validation {
    condition     = can(regex("^arn:[^:]+:iam::[0-9]{12}:(role|user)/.+$", var.cluster_admin_principal_arn))
    error_message = "cluster_admin_principal_arn must be an IAM role or IAM user ARN, not an STS assumed-role session ARN."
  }
}

variable "enabled_cluster_log_types" {
  description = "EKS control plane log types to send to CloudWatch Logs."
  type        = list(string)
  default = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  validation {
    condition = alltrue([
      for log_type in var.enabled_cluster_log_types :
      contains(["api", "audit", "authenticator", "controllerManager", "scheduler"], log_type)
    ])
    error_message = "enabled_cluster_log_types may contain only api, audit, authenticator, controllerManager, and scheduler."
  }
}

variable "node_instance_types" {
  description = "EC2 instance types for the managed node group."
  type        = list(string)

  validation {
    condition     = length(var.node_instance_types) > 0
    error_message = "node_instance_types must contain at least one instance type."
  }
}

variable "node_min_size" {
  description = "Minimum number of nodes in the managed node group."
  type        = number

  validation {
    condition     = var.node_min_size >= 0
    error_message = "node_min_size must be greater than or equal to 0."
  }
}

variable "node_desired_size" {
  description = "Desired number of nodes in the managed node group."
  type        = number

  validation {
    condition     = var.node_desired_size >= var.node_min_size && var.node_desired_size <= var.node_max_size
    error_message = "node_desired_size must be between node_min_size and node_max_size."
  }
}

variable "node_max_size" {
  description = "Maximum number of nodes in the managed node group."
  type        = number

  validation {
    condition     = var.node_max_size >= var.node_min_size
    error_message = "node_max_size must be greater than or equal to node_min_size."
  }
}

variable "node_disk_size" {
  description = "Root EBS volume size in GiB for managed node group instances."
  type        = number

  validation {
    condition     = var.node_disk_size >= 20
    error_message = "node_disk_size must be at least 20 GiB."
  }
}

variable "node_capacity_type" {
  description = "Capacity type for the managed node group."
  type        = string

  validation {
    condition     = contains(["ON_DEMAND", "SPOT", "CAPACITY_BLOCK"], var.node_capacity_type)
    error_message = "node_capacity_type must be ON_DEMAND, SPOT, or CAPACITY_BLOCK."
  }
}

variable "node_labels" {
  description = "Kubernetes labels applied to managed node group nodes."
  type        = map(string)
  default     = {}
}

variable "node_taints" {
  description = "Optional taints applied to managed node group nodes."
  type = list(object({
    key    = string
    value  = optional(string)
    effect = string
  }))
  default = []

  validation {
    condition = alltrue([
      for taint in var.node_taints :
      contains(["NO_SCHEDULE", "NO_EXECUTE", "PREFER_NO_SCHEDULE"], taint.effect)
    ])
    error_message = "node_taints effects must be NO_SCHEDULE, NO_EXECUTE, or PREFER_NO_SCHEDULE."
  }
}

variable "attach_cni_policy_to_node_role" {
  description = "Temporarily attach AmazonEKS_CNI_Policy to the node IAM role during fresh cluster bootstrap."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags applied to EKS resources."
  type        = map(string)
  default     = {}
}
