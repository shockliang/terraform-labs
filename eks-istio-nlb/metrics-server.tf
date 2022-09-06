locals {
  metrics_server_chart_url     = "https://kubernetes-sigs.github.io/metrics-server"
  metrics_server_chart_version = "3.8.2"
}

resource "helm_release" "metrics_server" {
  repository      = local.metrics_server_chart_url
  chart           = "metrics-server"
  name            = "metrics-server"
  version         = local.metrics_server_chart_version
  namespace       = kubernetes_namespace.monitoring.id
  cleanup_on_fail = true
}