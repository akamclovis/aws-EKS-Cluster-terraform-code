resource "kubernetes_manifest" "nginx_demo_application" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name      = "nginx-demo"
      namespace = kubernetes_namespace_v1.argocd.metadata[0].name
      finalizers = [
        "resources-finalizer.argocd.argoproj.io"
      ]
    }

    spec = {
      project = "default"

      source = {
        repoURL        = "https://github.com/akamclovis/aws-EKS-Cluster-terraform-code.git"
        targetRevision = "main"
        path           = "gitops/apps/nginx-demo"
      }

      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "gitops-demo"
      }

      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
        syncOptions = [
          "CreateNamespace=true"
        ]
      }
    }
  }

  depends_on = [
    helm_release.argocd
  ]
}
