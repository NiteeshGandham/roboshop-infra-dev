# Fetch an AWS Managed Policy by its standard name
data "aws_cloudfront_cache_policy" "cachingdisabled" {
  name = "Managed-CachingDisabled"
}


data "aws_cloudfront_cache_policy" "cachingoptimized" {
  name = "Managed-CachingOptimized"
}

data "aws_ssm_parameter" "acm_certificate_arn" {
  name = "/${var.project}/${var.environment}/frontend_alb_certificate_arn"
}