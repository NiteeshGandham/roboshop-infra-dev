resource "aws_ssm_parameter" "mongodb_sg_id" {
  name  = "/${var.project}/${var.environment}/backend_alb_listner_arn"
  type  = "String"
  value = aws_lb_listener.http.arn
}