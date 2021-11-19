output "postgres_endpoint" {
  value = "${aws_db_instance.postgres.endpoint}"
  description = "postgres endpoint"
}
output "postgres_address" {
  value = "${aws_db_instance.postgres.address}"
  description = "postgres address"
}
output "postgres_status" {
  value = "${aws_db_instance.postgres.status}"
  description = "postgres status"
}
output "postgres_availability_zone" {
  value = "${aws_db_instance.postgres.availability_zone}"
  description = "postgres availability zone"
}
output "postgres_multi_az" {
  value = "${aws_db_instance.postgres.multi_az}"
  description = "is it multi az?"
}
output "postgres_engine_version" {
  value = "${aws_db_instance.postgres.engine_version}"
  description = "postgres version"
}
output "postgres_resource_id" {
  value = "${aws_db_instance.postgres.resource_id}"
  description = "postgres instance id"
}
output "postgres_storage_encrypted" {
  value = "${aws_db_instance.postgres.storage_encrypted}"
  description = "is storage encrypted"
}
output "postgres_backup_retention_period" {
  value = "${aws_db_instance.postgres.backup_retention_period}"
  description = "The retention period of backup in days"
}
output "postgres_maintenance_window" {
  value = "${aws_db_instance.postgres.maintenance_window}"
  description = "The maintenance window in UTC 24hrs"
}
output "postgres_password" {
  value = "${random_string.dbpass.id}"
  description = "The password for the DB"
}
