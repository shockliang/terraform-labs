locals {
  kube_prometheus_stack_charts_url = "https://prometheus-community.github.io/helm-charts"
  kube_prometheus_stack_version    = "39.7.0"
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "kube-prometheus-statck" {
  repository      = local.kube_prometheus_stack_charts_url
  chart           = "kube-prometheus-stack"
  name            = "monitoring"
  version         = local.kube_prometheus_stack_version
  namespace       = kubernetes_namespace.monitoring.id
  values          = ["${file("kube-prometheus-stack-values.yaml")}"]
  cleanup_on_fail = true
  timeout         = 600
  depends_on = [
    kubernetes_namespace.monitoring,
    helm_release.metrics_server,
    helm_release.istio-ingressgateway
  ]
}
