# aws vars - GLOBAL
variable "availability_zone" {}
variable "subnet_id" {}
variable "cluster_name" {}
variable "of_version" {}


# postgres variables
variable "rds_storage" {}
variable "rds_name" {}
variable "rds_username" {}
variable "rds_port" {}
variable "rds_instance_type" {}
variable "rds_subnet_group" {}
variable "rds_security_group" {}
variable "rds_multi_az" {}
