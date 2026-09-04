variable "name_prefix" {
  description = "Name prefix used for ExternalDNS AWS resources."
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "route53_zone_id" {
  description = "Route53 hosted zone ID ExternalDNS is allowed to manage."
  type        = string
}

variable "tags" {
  description = "Tags to apply to ExternalDNS AWS resources."
  type        = map(string)
  default     = {}
}
