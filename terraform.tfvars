################## AWS TERRAFORMTFVARS ##########################
# aws variables - GLOBAL
aws_private_key =  ""

of_version = 1
cluster_name = "test1"
config_path = "config3"

# default tag variables
tag_environment = ""
tag_owner = ""
tag_project = ""

availability_zone = [""]
subnet_id = [""]
key_name        = ""
iam_instance_profile_master = ""
iam_instance_profile_node = ""
iam_pod_annotations_role = ""
autoscaling_group_name = ""
aws_elb                = ""
aws_region = ""

#rds variables
rds_storage = ""
rds_name    = ""
rds_username  = ""
rds_port      = ""
rds_instance_type = ""
rds_subnet_group  =""
rds_security_group = [""]

rds_multi_az = ""


#########K8 variables###########
ami_id = ""
vpc_id = ""
security_groups = [""]
security_groups_names = ""
exc_dev_key = ""

#EBS#
size            = ""
type            = ""
k8s_EBS_name    = ""
k8s_snap        = ""
k8snode_snap    = ""
of_domain       = ""
of_svc_domain   = ""

#helm
chart_nginx             = ""
chart_openldap          = ""
chart_kiam              = ""
chart_apache            = ""
chart_velero            = ""
chart_phpldapadmin      = ""
chart_opendistro        = "opendistro-es-chart"
chart_logstash          = "logstash-chart"
chart_filebeat          = "filebeat-chart"


#cloudwatch#
alarm_name             = ""
comparison_operator    = ""
evaluation_periods     = ""
period                 = ""
metric_name            = ""
threshold              = ""
alarm_actions          = [""]
actions_enabled        = ""
alarm_description      = ""

#K8s#
k8s_instance_type = ""
k8s_hostname      = ""
k8snode_instance_type = ""
k8snode_hostname      = ""
k8snode_count = ""
docker_reg = ""

#nginx#
controller_kind = ""
controller_service_type = ""
controller_service_httpPort_nodePort = ""
controller_service_httpsPort_nodePort = ""
controller_defaultTLS_cert = ""
controller_defaultTLS_key = ""
controller_defaultTLS_secret = ""
controller_wildcardTLS_cert = ""
controller_wildcardTLS_key = ""
controller_wildcardTLS_secret = ""
