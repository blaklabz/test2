resource "helm_release" "logstash" {
  name       = "logstash"
  chart      = "${var.chart_logstash}"
  create_namespace = "false"
  namespace  = "opendistro"
}
