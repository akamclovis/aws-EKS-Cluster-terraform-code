resource "kubernetes_namespace_v1" "external_dns" {
  metadata {
    name = "external-dns"
    labels = {
      "app.kubernetes.io/name"       = "external-dns"
      "app.kubernetes.io/part-of"    = "eks-platform"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "kubernetes_service_account_v1" "external_dns" {
  metadata {
    name      = "external-dns"
    namespace = kubernetes_namespace_v1.external_dns.metadata[0].name
    labels = {
      "app.kubernetes.io/name"       = "external-dns"
      "app.kubernetes.io/part-of"    = "eks-platform"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"
  version    = var.external_dns_chart_version
  namespace  = kubernetes_namespace_v1.external_dns.metadata[0].name

  values = [
    yamlencode({
      provider = {
        name = "aws"
      }
      sources       = ["ingress"]
      policy        = "sync"
      registry      = "txt"
      txtOwnerId    = data.terraform_remote_state.core.outputs.cluster_name
      domainFilters = [var.external_dns_domain]
      zoneIdFilters = [data.aws_route53_zone.external_dns.zone_id]
      serviceAccount = {
        create = false
        name   = kubernetes_service_account_v1.external_dns.metadata[0].name
      }
    })
  ]

  depends_on = [
    kubernetes_service_account_v1.external_dns
  ]
}
