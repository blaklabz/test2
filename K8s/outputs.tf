/*output "node_ip" {
  value = "${aws_instance.K8snode.private_ip}"
  description = "node ip"
}

output "master_ip" {
  value = "${aws_instance.K8s_master.private_ip}"
  description = "master ip"
}*/

output "API_ELB_dns_name" {
  value = "${aws_elb.api-lb.dns_name}"
  description = "API LB dns"
}

output "SVC_ELB_dns_name" {
  value = "${aws_elb.svc-lb.dns_name}"
  description = "SVC LB dns"
}
