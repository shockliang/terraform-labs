provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      # This requires the awscli to be installed locally where Terraform is executed
      args = ["eks", "get-token", "--cluster-name", module.eks.cluster_id]
    }
  }
}

locals {
  istio_charts_url = "https://istio-release.storage.googleapis.com/charts"
}

resource "kubernetes_namespace" "istio-system" {
  metadata {
    name = "istio-system"
    labels = {
      istio-injection = "enabled"
    }
  }
}

resource "helm_release" "istio-base" {
  repository      = local.istio_charts_url
  chart           = "base"
  name            = "istio-base"
  version         = var.istio_version
  namespace       = kubernetes_namespace.istio-system.id
  cleanup_on_fail = true
  # timeout         = 120
}

resource "helm_release" "istiod" {
  repository      = local.istio_charts_url
  chart           = "istiod"
  name            = "istiod"
  version         = var.istio_version
  namespace       = kubernetes_namespace.istio-system.id
  # timeout         = 120
  cleanup_on_fail = true
  depends_on = [helm_release.istio-base]
}

resource "helm_release" "istio-ingress" {
  repository      = local.istio_charts_url
  chart           = "gateway"
  name            = "istio-ingress"
  namespace       = kubernetes_namespace.istio-system.id
  version         = var.istio_version
  # timeout         = 500
  cleanup_on_fail = true
  depends_on = [helm_release.istiod]
}
