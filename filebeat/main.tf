resource "helm_release" "filebeat" {
  name       = "filebeat"
  chart      = "${var.chart_filebeat}"
  create_namespace = "false"
  namespace  = "opendistro"
}
