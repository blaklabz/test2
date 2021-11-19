resource "helm_release" "opendistro" {
  name       = "opendistro"
  chart      = "${var.chart_opendistro}"
  create_namespace = "false"
  namespace  = "opendistro"
}
