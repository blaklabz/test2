
# aws vars - GLOBAL
variable "aws_private_key" {}
variable "cluster_name" {}
variable "of_version" {}
variable "availability_zone" {}
variable "subnet_id" {}
variable "ami_id" {}
variable "vpc_id" {}
variable "exc_dev_key" {}
variable "security_groups" {}
variable "security_groups_names" {}
variable "key_name" {}
variable "iam_instance_profile_master" {}
variable "iam_instance_profile_node" {}
variable "autoscaling_group_name" {}
variable "aws_elb" {}
#variable "availability_zones" {}


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
variable "postgres_endpoint" {}
variable "postgres_password" {}
variable "rds_username" {}
variable "k8snode_count" {}
variable "docker_reg" {}
variable "of_domain" {}
variable "of_svc_domain" {}
