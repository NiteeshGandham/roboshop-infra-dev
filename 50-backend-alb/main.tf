resource "aws_lb" "backend-alb" {
  name               = "${var.project}-${var.environment}"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.backend_alb_sg_id]
  subnets            = [local.private_subnet_ids]

  enable_deletion_protection = false # we cant delete using terraform if we give true. so for practice


  tags =  merge (
   
   
    {
        Name = "${var.project}-${var.environment}"
    },

  )
  }


  resource "aws_lb_listener" "backend-alb" {
  load_balancer_arn = aws_lb.backend-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "<h1>This is HTTP backend alb </h1>"
      status_code  = "200"
    }
  }
}




resource "aws_route53_record" "lbackend-alb" {
  zone_id = var.zone_id
  name    = "*.backend-alb-${var.environment}.${var.domain_name}.com"
  type    = "A"

    #load balancer details
  alias {
    name                   = aws_lb.backend-alb.dns_name
    zone_id                = aws_lb.backend-alb.zone_id
    evaluate_target_health = true
  }
}