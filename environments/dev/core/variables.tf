variable "project_name" {
  description = "Short project identifier used for naming and tagging AWS resources."
  type        = string
}

variable "environment" {
  description = "Deployment environment name, such as dev, staging, or prod."
  type        = string
}

variable "aws_region" {
  description = "AWS region where the environment will be deployed."
  type        = string
}

variable "owner" {
  description = "Owner tag value used to identify the team or person responsible for the environment."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the environment VPC."
  type        = string
}

variable "availability_zones" {
  description = "Exactly three Availability Zones used by the dev environment."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks, one per Availability Zone."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks, one per Availability Zone."
  type        = list(string)
}

variable "single_nat_gateway" {
  description = "When true, use a single NAT Gateway for lower-cost development environments."
  type        = bool
}

variable "additional_tags" {
  description = "Additional tags to merge with standard tags."
  type        = map(string)
  default     = {}
}

variable "cluster_name" {
  description = "Optional EKS cluster name. Defaults to the project/environment name prefix when null."
  type        = string
  default     = null
}

variable "cluster_version" {
  description = "Kubernetes minor version for the EKS cluster."
  type        = string
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
  description = "CIDR blocks allowed to access the public EKS API endpoint. Do not use 0.0.0.0/0."
  type        = list(string)
}

variable "cluster_admin_principal_arn" {
  description = "IAM role or user ARN granted initial EKS cluster administrator access. Do not use an STS assumed-role session ARN."
  type        = string
}

variable "node_instance_types" {
  description = "EC2 instance types for the EKS managed node group."
  type        = list(string)
}

variable "node_min_size" {
  description = "Minimum number of nodes in the managed node group."
  type        = number
}

variable "node_desired_size" {
  description = "Desired number of nodes in the managed node group."
  type        = number
}

variable "node_max_size" {
  description = "Maximum number of nodes in the managed node group."
  type        = number
}

variable "node_disk_size" {
  description = "Root EBS volume size in GiB for managed node group instances."
  type        = number
}

variable "node_capacity_type" {
  description = "Capacity type for the managed node group."
  type        = string
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
}

variable "attach_cni_policy_to_node_role" {
  description = "Temporarily attach AmazonEKS_CNI_Policy to the node IAM role during fresh cluster bootstrap."
  type        = bool
  default     = true
}
