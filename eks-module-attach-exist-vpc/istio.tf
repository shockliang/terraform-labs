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
  repository = local.istio_charts_url
  chart      = "istiod"
  name       = "istiod"
  version    = var.istio_version
  namespace  = kubernetes_namespace.istio-system.id
  # timeout         = 120
  cleanup_on_fail = true
  depends_on      = [helm_release.istio-base]
}

resource "helm_release" "istio-ingressgateway" {
  repository = local.istio_charts_url
  chart      = "gateway"
  name       = "istio-ingressgateway"
  namespace  = kubernetes_namespace.istio-system.id
  version    = var.istio_version
  values = [
    templatefile("istio-values.tftpl", { primary-subnet-id = "${aws_subnet.eks-node-primary-subnet.id}" })
  ]
  # timeout         = 500
  cleanup_on_fail = true
  depends_on      = [helm_release.istiod]
}
