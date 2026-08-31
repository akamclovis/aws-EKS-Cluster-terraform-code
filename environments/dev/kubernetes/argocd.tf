resource "kubernetes_namespace_v1" "argocd" {
  metadata {
    name = "argocd"
    labels = {
      "app.kubernetes.io/name"       = "argocd"
      "app.kubernetes.io/part-of"    = "eks-platform"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "10.4.1"
  namespace  = kubernetes_namespace_v1.argocd.metadata[0].name

  values = [
    file("${path.module}/../../../helm-values/argocd-values.yaml")
  ]

  depends_on = [
    kubernetes_namespace_v1.argocd
  ]
}
