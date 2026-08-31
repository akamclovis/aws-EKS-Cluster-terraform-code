variable "name_prefix" {
  description = "Name prefix used for AWS Load Balancer Controller resources."
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "tags" {
  description = "Tags to apply to AWS Load Balancer Controller AWS resources."
  type        = map(string)
  default     = {}
}
