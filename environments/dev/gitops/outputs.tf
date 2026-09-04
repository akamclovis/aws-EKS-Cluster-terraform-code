output "nginx_demo_application_name" {
  description = "Name of the Argo CD Application that manages the nginx demo workload."
  value       = "nginx-demo"
}

output "nginx_demo_application_namespace" {
  description = "Namespace containing the nginx demo Argo CD Application."
  value       = "argocd"
}
