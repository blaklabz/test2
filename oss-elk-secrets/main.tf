provider "kubernetes" {
  config_path    = "${var.config_path}"
}

resource "null_resource" "dependency_getter" {
  # provisioner "local-exec" {
  #   command = "echo ${var.helm_k8s_node_ip}"
  # }
}

resource "kubernetes_secret" "fbeat-secrets" {
  type  = "Opaque"

  metadata {
    name      = "fbeat-secrets"
    namespace = "opendistro"
  }

  data = {
    "root-ca.pem" = "${file("./secrets/opendistro/root-ca.pem")}"
    "esnode.pem" = "${file("./secrets/opendistro/esnode.pem")}"
    "esnode-key.pem" = "${file("./secrets/opendistro/esnode-key.pem")}"
  }
}
