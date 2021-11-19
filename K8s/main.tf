resource "random_string" "k3s_token" {
  length           = 32
  special          = false
}

data "aws_default_tags" "default_tags" {}


#Create load balancers

resource "aws_elb" "api-lb" {
  name               = "${var.cluster_name}-api-lb"
  #availability_zones = var.availability_zone
  subnets            =  var.subnet_id
  security_groups    =  var.security_groups
  #instances          = [aws_instance.K8s_master.id]
  internal           = true


  listener {
    instance_port      = 6443
    instance_protocol  = "TCP"
    lb_port            = 6443
    lb_protocol        = "TCP"

  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 3
    target              = "TCP:22"
    interval            = 5
  }


  tags = {
    Name = "${var.cluster_name}-api-lb"
  }
}

resource "aws_elb" "svc-lb" {
  name               = "${var.cluster_name}-svc-lb"
  #availability_zones = var.availability_zone
  subnets            =  var.subnet_id
  security_groups    =  var.security_groups
  internal           = true
  #instances          = [aws_instance.K8snode.id]


  listener {
    instance_port      = 32325
    instance_protocol  = "TCP"
    lb_port            = 443
    lb_protocol        = "TCP"
  }

  listener {
    instance_port      = 32624
    instance_protocol  = "TCP"
    lb_port            = 80
    lb_protocol        = "TCP"
  }


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 3
    target              = "TCP:22"
    interval            = 5
  }


  tags = {
    Name = "${var.cluster_name}-svc-lb"
  }
}

# autoscaling

resource "aws_autoscaling_group" "master" {
  #availability_zones =  ["us-east-1c"]
  name = "${var.cluster_name}-master_ASG"
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2
  vpc_zone_identifier       = var.subnet_id
  load_balancers = ["${aws_elb.api-lb.name}"]
  health_check_type = "ELB"

  launch_template {
    id      = aws_launch_template.master.id
    version = "$Latest"
  }

  dynamic "tag" {
    for_each = data.aws_default_tags.default_tags.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}



#autoscaling
resource "aws_autoscaling_group" "worker" {
  #availability_zones =  ["us-east-1c"]
  name = "${var.cluster_name}-worker_ASG"
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2
  vpc_zone_identifier       = var.subnet_id
  load_balancers = ["${aws_elb.svc-lb.name}"]
  health_check_type = "ELB"

  launch_template {
    id      = aws_launch_template.worker.id
    version = "$Latest"
  }

  dynamic "tag" {
    for_each = data.aws_default_tags.default_tags.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}


#autoscaling

resource "aws_launch_template" "master" {
  image_id      = "${var.ami_id}"
  instance_type = "${var.k8s_instance_type}"
  vpc_security_group_ids = var.security_groups
  iam_instance_profile {
    name = "${var.iam_instance_profile_master}"
  }

  #user_data = "${data.template_file.userdata.rendered}"
  user_data = base64encode(templatefile("K8s/master_user_data.sh",
    {
      of_version = "${var.cluster_name}"
      lb_dns = "${aws_elb.api-lb.dns_name}",
      rds_username = "${var.rds_username}",
      postgres_password = "${var.postgres_password}",
      postgres_endpoint = "${var.postgres_endpoint}",
      token = "${random_string.k3s_token.id}"
      of_domain = "${var.of_domain}"
      of_subdomain = "${var.cluster_name}-master"
    }
  ))



  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.cluster_name}-master${var.of_domain}"
      unique-name = "octet"
    }
  }
}

resource "aws_launch_template" "worker" {
  image_id      = "${var.ami_id}"
  instance_type = "${var.k8s_instance_type}"
  vpc_security_group_ids = var.security_groups
  iam_instance_profile {
    name = "${var.iam_instance_profile_node}"
  }

  #user_data = "${filebase64("K8s/worker_user_data.sh")}"
  user_data = base64encode(templatefile("K8s/worker_user_data.sh",
    {
      lb_dns = "${aws_elb.api-lb.dns_name}",
      token = "${random_string.k3s_token.id}"
      of_domain = "${var.of_domain}"
      of_subdomain = "${var.cluster_name}-worker"
    }
  ))

  block_device_mappings {
    device_name = "/dev/xvdf"
    ebs {
      volume_size = 100
      volume_type = "gp2"
      delete_on_termination = true
      encrypted = false
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.cluster_name}-worker${var.of_domain}"
      unique-name = "octet"
    }
  }
}
