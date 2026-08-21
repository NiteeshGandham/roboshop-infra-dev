  resource "aws_security_group_rule" "bastion_internet" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = local.Bastion_sg_id
  }


#mongo
  resource "aws_security_group_rule" "mongodb_bastion" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.Bastion_sg_id
    security_group_id = local.mongodb_sg_id
  }


  resource "aws_security_group_rule" "mongodb_catalogue" {
    type              = "ingress"
    from_port         = 27017
    to_port           = 27017
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.catalogue_sg_id
    security_group_id = local.mongodb_sg_id
  }

  resource "aws_security_group_rule" "mongodb_user" {
    type              = "ingress"
    from_port         = 27017
    to_port           = 27017
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.user_sg_id
    security_group_id = local.mongodb_sg_id
  }


#redis
resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  #where traffic coming from
  source_security_group_id  = local.Bastion_sg_id
  security_group_id = local.redis_sg_id
  }

resource "aws_security_group_rule" "redis_cart" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  #where traffic coming from
  source_security_group_id  = local.cart_sg_id
  security_group_id = local.redis_sg_id
  }

resource "aws_security_group_rule" "redis_user" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  #where traffic coming from
  source_security_group_id  = local.user_sg_id
  security_group_id = local.redis_sg_id
  }


#mysql
  resource "aws_security_group_rule" "mysql_bastion" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.Bastion_sg_id
    security_group_id = local.mysql_sg_id
  }

  resource "aws_security_group_rule" "mysql_shipping" {
    type              = "ingress"
    from_port         = 3306
    to_port           = 3306
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.shipping_sg_id
    security_group_id = local.mysql_sg_id
  }



  #rabbitmq
  resource "aws_security_group_rule" "rabbitmq_bastion" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.Bastion_sg_id
    security_group_id = local.rabbitmq_sg_id
  }
  resource "aws_security_group_rule" "rabbitmq_payment" {
    type              = "ingress"
    from_port         = 5672
    to_port           = 5672
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.payment_sg_id
    security_group_id = local.rabbitmq_sg_id
  }






  #catalogue
  resource "aws_security_group_rule" "catalogue_bastion" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.Bastion_sg_id
    security_group_id = local.catalogue_sg_id
  }

    resource "aws_security_group_rule" "backend-alb-catalogue" {
    type              = "ingress"
    from_port         = 8080
    to_port           = 8080
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.backend_alb_sg_id
    security_group_id = local.catalogue_sg_id
  }


 #user
  resource "aws_security_group_rule" "user_bastion" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.Bastion_sg_id
    security_group_id = local.user_sg_id
  }

    resource "aws_security_group_rule" "backend-alb-user" {
    type              = "ingress"
    from_port         = 8080
    to_port           = 8080
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.backend_alb_sg_id
    security_group_id = local.user_sg_id
  }




   #cart
  resource "aws_security_group_rule" "cart_bastion" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.Bastion_sg_id
    security_group_id = local.cart_sg_id
  }

    resource "aws_security_group_rule" "backend-alb-cart" {
    type              = "ingress"
    from_port         = 8080
    to_port           = 8080
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.backend_alb_sg_id
    security_group_id = local.cart_sg_id
  }

 #shipping
  resource "aws_security_group_rule" "shipping_bastion" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.Bastion_sg_id
    security_group_id = local.shipping_sg_id
  }

    resource "aws_security_group_rule" "backend-alb-shipping" {
    type              = "ingress"
    from_port         = 8080
    to_port           = 8080
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.backend_alb_sg_id
    security_group_id = local.shipping_sg_id
  }



 #payment
  resource "aws_security_group_rule" "shipping_payment" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.Bastion_sg_id
    security_group_id = local.payment_sg_id
  }

    resource "aws_security_group_rule" "backend-alb-payment" {
    type              = "ingress"
    from_port         = 8080
    to_port           = 8080
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.backend_alb_sg_id
    security_group_id = local.payment_sg_id
  }

#backend alb should accept connection from all the backend servers
  #bastion
  resource "aws_security_group_rule" "backend_alb_bastion" {
    type              = "ingress"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.Bastion_sg_id
    security_group_id = local.backend_alb_sg_id
  }


    #catalogue
  resource "aws_security_group_rule" "backend_alb_catalogue" {
    type              = "ingress"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.catalogue_sg_id
    security_group_id = local.backend_alb_sg_id
  }

   #user
  resource "aws_security_group_rule" "backend_alb_user" {
    type              = "ingress"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.user_sg_id
    security_group_id = local.backend_alb_sg_id
  }

 #cart
  resource "aws_security_group_rule" "backend_alb_cart" {
    type              = "ingress"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.cart_sg_id
    security_group_id = local.backend_alb_sg_id
  }


   #shipping
  resource "aws_security_group_rule" "backend_alb_shipping" {
    type              = "ingress"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.shipping_sg_id
    security_group_id = local.backend_alb_sg_id
  }

  #payment
  resource "aws_security_group_rule" "backend_alb_payment" {
    type              = "ingress"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.payment_sg_id
    security_group_id = local.backend_alb_sg_id
  }
  #frontend
  resource "aws_security_group_rule" "backend_alb_frontend" {
    type              = "ingress"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.frontend_sg_id
    security_group_id = local.backend_alb_sg_id
  }





  resource "aws_security_group_rule" "frontend-alb-public" {
    type              = "ingress"
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    #where traffic coming from
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = local.frontend_alb_sg_id
  }

    resource "aws_security_group_rule" "frontend-alb-frontend" {
    type              = "ingress"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.frontend_alb_sg_id
    security_group_id = local.frontend_sg_id
  }

   resource "aws_security_group_rule" "frontend_bastion" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    #where traffic coming from
    source_security_group_id  = local.Bastion_sg_id
    security_group_id = local.frontend_sg_id
  }