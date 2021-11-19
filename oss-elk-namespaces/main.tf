provider "kubernetes" {
  config_path    = "${var.config_path}"
}

resource "kubernetes_namespace" "opendistro" {
  metadata {
    name = "opendistro"
  }
}
