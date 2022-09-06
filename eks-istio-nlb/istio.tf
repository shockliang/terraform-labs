locals {
  istio_charts_url = "https://istio-release.storage.googleapis.com/charts"
  istio_version    = "1.14.3"
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
  version         = local.istio_version
  namespace       = kubernetes_namespace.istio-system.id
  cleanup_on_fail = true
  depends_on      = [kubernetes_namespace.istio-system]
  # timeout         = 120
}

resource "helm_release" "istiod" {
  repository = local.istio_charts_url
  chart      = "istiod"
  name       = "istiod"
  version    = local.istio_version
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
  version    = local.istio_version
  # timeout         = 500
  cleanup_on_fail = true
  values = [
    templatefile("istio-values.tftpl", { primary-subnet-id = "${aws_subnet.eks-node-primary-subnet.id}" })
  ]
  depends_on = [helm_release.istiod]
}
