# aws vars - GLOBAL
variable "cluster_name" {}
variable "of_version" {}
variable "config_path" {}
variable "availability_zone" {}
variable "subnet_id" {}
variable "ami_id" {}
variable "vpc_id" {}
variable "exc_dev_key" {}
variable "security_groups" {}
variable "aws_private_key" {}
variable "key_name" {}
variable "iam_instance_profile_master" {}
variable "iam_instance_profile_node" {}
variable "iam_pod_annotations_role" {}
#variable "iam_instance_profile" {}
variable "autoscaling_group_name" {}
variable "aws_elb" {}
#variable "availability_zones" {}
variable "security_groups_names" {}
variable "aws_region" {}

# default tag variables
variable "tag_environment" {}
variable "tag_owner" {}
variable "tag_project" {}

# postgres variables
variable "rds_storage" {}
variable "rds_name" {}
variable "rds_username" {}
variable "rds_port" {}
variable "rds_instance_type" {}
variable "rds_subnet_group" {}
variable "rds_security_group" {}
variable "rds_multi_az" {}

# Helm
variable "chart_nginx" {}
variable "chart_openldap" {}
variable "chart_kiam" {}
variable "chart_velero" {}
variable "chart_apache" {}
variable "chart_phpldapadmin" {}

# EBS volume
variable "size" {}
variable "type" {}
variable "k8s_EBS_name" {}
variable "k8s_snap" {}
variable "k8snode_snap" {}

# Cloudwatch
variable "alarm_name" {}
variable "comparison_operator" {}
variable "evaluation_periods" {}
variable "period" {}
variable "metric_name" {}
variable "threshold" {}
variable "alarm_actions" {}
variable "actions_enabled" {}
variable "alarm_description" {}

# K8s variables
variable "k8s_hostname" {}
variable "k8s_instance_type" {}
variable "k8snode_hostname" {}
variable "k8snode_instance_type" {}
variable "k8snode_count" {}
variable "docker_reg" {}
variable "of_domain" {}
variable "of_svc_domain" {}

# Nginx
variable "controller_kind" {}
variable "controller_service_type" {}
variable "controller_service_httpPort_nodePort" {}
variable "controller_service_httpsPort_nodePort" {}
variable "controller_defaultTLS_cert" {}
variable "controller_defaultTLS_key" {}
variable "controller_defaultTLS_secret" {}
variable "controller_wildcardTLS_cert" {}
variable "controller_wildcardTLS_key" {}
variable "controller_wildcardTLS_secret" {}

## ELK logging solution
# opendistro
variable "chart_opendistro" {}
# logstash
variable "chart_logstash" {}
# filebeat
variable "chart_filebeat" {}
