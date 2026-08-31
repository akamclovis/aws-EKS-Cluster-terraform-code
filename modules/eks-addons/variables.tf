variable "name_prefix" {
  description = "Prefix used for naming EKS add-on resources."
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes minor version used for EKS add-on version discovery."
  type        = string
}

variable "vpc_cni_addon_version" {
  description = "Approved VPC CNI add-on version. When null, the EKS-recommended compatible version is discovered temporarily."
  type        = string
  default     = null
}

variable "coredns_addon_version" {
  description = "Approved CoreDNS add-on version. When null, the EKS-recommended compatible version is discovered temporarily."
  type        = string
  default     = null
}

variable "kube_proxy_addon_version" {
  description = "Approved kube-proxy add-on version. When null, the EKS-recommended compatible version is discovered temporarily."
  type        = string
  default     = null
}

variable "pod_identity_agent_addon_version" {
  description = "Approved EKS Pod Identity Agent add-on version. When null, the EKS-recommended compatible version is discovered temporarily."
  type        = string
  default     = null
}

variable "tags" {
  description = "Common tags applied to EKS add-on resources."
  type        = map(string)
  default     = {}
}
