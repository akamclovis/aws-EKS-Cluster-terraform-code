resource "helm_release" "loki" {
  name       = "loki"
  repository = "https://grafana-community.github.io/helm-charts"
  chart      = "loki"
  version    = var.loki_chart_version
  namespace  = kubernetes_namespace_v1.monitoring.metadata[0].name

  values = [
    file("${path.module}/../../../helm-values/loki-values.yaml")
  ]

  depends_on = [
    kubernetes_namespace_v1.monitoring
  ]
}
