resource "random_string" "dbpass" {
  length           = 32
  special          = false
}

data "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.rds_subnet_group}"
}

data "aws_default_tags" "default_tags" {}

resource "aws_db_instance" "postgres" {
  allocated_storage        = "${var.rds_storage}"
  backup_retention_period  = 0   # in days
  #db_subnet_group_name     = "${var.rds_subnet_group}"
  db_subnet_group_name     = data.aws_db_subnet_group.db_subnet_group.name
  #availability_zone        = "${var.availability_zone}"
  engine                   = "postgres"
  engine_version           = "11.5"
  allow_major_version_upgrade = false
  auto_minor_version_upgrade = false
  maintenance_window       = "Tue:00:30-Tue:04:30" #in UTC
  deletion_protection      = false
  instance_class           = "${var.rds_instance_type}"
  name                     = "${var.cluster_name}rds"
  identifier               = "${var.cluster_name}rds"
  password                 = random_string.dbpass.id
  port                     = "${var.rds_port}"
  publicly_accessible      = false
  storage_encrypted        = true # you should always do this
  storage_type             = "gp2"
  username                 = "${var.rds_username}"
  vpc_security_group_ids   = "${var.rds_security_group}"
  multi_az                 = "${var.rds_multi_az}"
  skip_final_snapshot      = true
}
