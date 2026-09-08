output "monitoring_namespace" {
  description = "Namespace where observability components are installed."
  value       = kubernetes_namespace_v1.monitoring.metadata[0].name
}

output "kube_prometheus_stack_release_name" {
  description = "Name of the kube-prometheus-stack Helm release."
  value       = helm_release.kube_prometheus_stack.name
}

output "kube_prometheus_stack_chart_version" {
  description = "Pinned kube-prometheus-stack Helm chart version."
  value       = helm_release.kube_prometheus_stack.version
}

output "loki_release_name" {
  description = "Name of the Loki Helm release."
  value       = helm_release.loki.name
}

output "loki_chart_version" {
  description = "Pinned Loki Helm chart version."
  value       = helm_release.loki.version
}

output "alloy_release_name" {
  description = "Name of the Grafana Alloy Helm release."
  value       = helm_release.alloy.name
}

output "alloy_chart_version" {
  description = "Pinned Grafana Alloy Helm chart version."
  value       = helm_release.alloy.version
}
