output "efs_storage_class_name" {
  description = "Name of the Kubernetes StorageClass for dynamic EFS provisioning."
  value       = kubernetes_storage_class_v1.efs.metadata[0].name
}

output "alb_controller_service_account_name" {
  description = "Name of the AWS Load Balancer Controller ServiceAccount."
  value       = kubernetes_service_account_v1.aws_load_balancer_controller.metadata[0].name
}

output "alb_controller_helm_release_name" {
  description = "Name of the AWS Load Balancer Controller Helm release."
  value       = helm_release.aws_load_balancer_controller.name
}

output "argocd_namespace" {
  description = "Namespace where Argo CD is installed."
  value       = kubernetes_namespace_v1.argocd.metadata[0].name
}

output "argocd_helm_release_name" {
  description = "Name of the Argo CD Helm release."
  value       = helm_release.argocd.name
}

output "argocd_chart_version" {
  description = "Pinned Argo CD Helm chart version."
  value       = helm_release.argocd.version
}

output "external_dns_namespace" {
  description = "Namespace where ExternalDNS is installed."
  value       = kubernetes_namespace_v1.external_dns.metadata[0].name
}

output "external_dns_service_account_name" {
  description = "Name of the ExternalDNS ServiceAccount."
  value       = kubernetes_service_account_v1.external_dns.metadata[0].name
}

output "external_dns_helm_release_name" {
  description = "Name of the ExternalDNS Helm release."
  value       = helm_release.external_dns.name
}

output "external_dns_chart_version" {
  description = "Pinned ExternalDNS Helm chart version."
  value       = helm_release.external_dns.version
}
