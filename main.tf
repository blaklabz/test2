provider "helm" {
  kubernetes {
    config_path = "${var.config_path}"
  }
}

### ELK logging implementation ###

## build namespace and secrets
#module "oss-elk-namespaces" {
#  source                 = "./oss-elk-namespaces"
#  config_path            = "${var.config_path}"
#}

#module "oss-elk-secrets" {
#  source                 = "./oss-elk-secrets"
#  config_path            = "${var.config_path}"
#}

## Services
module "filebeat" {
    #depends_on          = [module.oss-elk-secrets]
    source              = "./filebeat"
    chart_filebeat      = "${var.chart_filebeat}"
}

module "opendistro" {
    #depends_on          = [module.oss-elk-secrets]
    source              = "./opendistro"
    chart_opendistro      = "${var.chart_opendistro}"
}

module "logstash" {
    #depends_on          = [module.oss-elk-secrets]
    source              = "./logstash"
    chart_logstash      = "${var.chart_logstash}"
}

# module "openldap" {
#   source              = "./openldap"
#   config_path         = "${var.config_path}"
#   chart_openldap      = "${var.chart_openldap}"
# }

# module "phpldapadmin" {
#   source              = "./phpldapadmin"
#   config_path         = "${var.config_path}"
#   chart_phpldapadmin      = "${var.chart_phpldapadmin}"
#
# }
#
# module "keycloak" {
#   source              = "./keycloak"
#   rds_admin = "dsofsa"
#   rds_admin_password = module.postgres.postgres_password
#   rds_endpoint = module.postgres.postgres_address
# }
#
# module "kiam" {
#   depends_on = [module.k8-namespaces]
#   source = "./kiam"
#   chart_kiam = "${var.chart_kiam}"
# }
#/*
# module "velero" {
#   depends_on = [module.kiam, module.k8-namespaces]
#   source = "./velero"
#   cluster_name = "${var.cluster_name}"
#   of_version = "${var.of_version}"
#   chart_velero = "${var.chart_velero}"
#   iam_pod_annotations_role = "${var.iam_pod_annotations_role}"
# }*/

# module "gitlab" {
#   source              = "./gitlab"
#   ebs-csi_metadata    = module.ebs-csi.ebs-csi_metadata
#   master_ip           = module.K8s.master_ip
# }
