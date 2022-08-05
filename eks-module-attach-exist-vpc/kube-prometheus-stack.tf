locals {
  kube_prometheus_stack_charts_url = "https://prometheus-community.github.io/helm-charts"
  kube_prometheus_stack_version = "39.2.1"
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
  values = [ "${file("prometheus.yaml")}" ]
  cleanup_on_fail = true
}
