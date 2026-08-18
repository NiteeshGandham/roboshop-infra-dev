  resource "aws_instance" "catalogue" {
    ami           = local.ami_id
    instance_type = "t3.micro"
    subnet_id = local.private_subnet_id
    vpc_security_group_ids = [local.catalogue_sg_id]

    tags =merge(
      local.tags,
      {
          Name = "${var.project}-${var.environment}-catalogue"
      }
      
    )
  }

  resource "terraform_data" "bootstrap" {
    triggers_replace  = [aws_instance.catalogue.id]

      connection {
      type = "ssh"
      user = "ec2-user"
      password = "DevOps321"
      host = aws_instance.catalogue.private_ip
    }

    provisioner "file" {
      source      = "bootstrap.sh" #local file path
      destination = "/tmp/bootstrap.sh" #destination path in remote
    }
    provisioner "remote-exec" {
      inline = [
          "chmod +x /tmp/bootstrap.sh",
          "sudo sh /tmp/bootstrap.sh catalogue" 
      ]
    }
  }

  resource "aws_ec2_instance_state" "catalogue" {
    instance_id = aws_instance.catalogue.id
    state       = "stopped"
    depends_on = [aws_instance.catalogue]
  }

resource "aws_ami_from_instance" "catalogue" {
  name = "${var.project}-${var.environment}-catalogue-${var.app_version}-${aws_instance.catalouge.id}"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [
  terraform_data.bootstrap,
  aws_ec2_instance_state.catalogue
]
  tags = merge(
    {
      Name = "${var.project}-${var.environment}-catalogue"
    }  
  )
  }




resource "aws_lb_target_group" "catalogue" {
  name     = "${var.project}-${var.environment}-catalogue"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  deregistration_delay = 60

  health_check {
    healthy_threshold = 2
    interval = 10
    matcher = "200-299"
    path = "/health"
    protocol = "HTTP"
    port = 8080
    timeout = 2
    unhealthy_threshold = 2
  }
}



resource "aws_launch_template" "catalogue" {
  name = "${var.project}-${var.environment}-catalogue"

  image_id = aws_ami_from_instance.catalogue.id

  # once autoscalling see less traffic it will terminate the instance 
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]

  # each the we apply terraform apply this version will be updated as default
  update_default_version = true

  # tags for instance created 
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project}-${var.environment}-catalogue"
    }
  }

  # tags for launch template
  tags = merge(
    {
      Name = "${var.project}-${var.environment}-catalogue"
    }  
  )
  }




resource "aws_autoscaling_group" "catalogue" {
  name                      = "${var.project}-${var.environment}-catalogue"
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 120
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = false
  launch_template {
    id      = aws_launch_template.catalogue.id
    version = "$Latest"
  }
  vpc_zone_identifier       = [local.private_subnet_id]
  target_group_arns = [aws_lb_target_group.catalogue.arn]

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }
  

  dynamic "tag" {
    for_each = merge(
      {
        Name = "${var.project}-${var.environment}-catalogue"
      }
    )
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
  }
  }

  # with in 15 min autoscalling should be successfull
  timeouts {
    delete = "15m"
  }

}





resource "aws_autoscaling_policy" "catalogue" {
  name                   = "${var.project}-${var.environment}-catalogue"
  policy_type        = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  estimated_instance_warmup = 120

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70.0
  }
}


resource "aws_lb_listener_rule" "catalouge" {
  listener_arn = local.backend_alb_listner_arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }

  condition {
    host_header {
      values = ["catalogue.backend-alb-${var.project}-${var.domain_name}"]
    }
  }
}




resource "terraform_data" "catalouge-delete" {
    triggers_replace  = [aws_instance.catalogue.id]
    depends_on = [aws_autoscaling_policy.catalogue]

    # it execute in bastion
    provisioner "local-exec" {
      command = "aws ec2 terminate-instances --instance-ids ${aws_instance.catalogue.id}"
  
    }
  }