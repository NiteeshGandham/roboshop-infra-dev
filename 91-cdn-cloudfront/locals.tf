locals {

caching_disabled = data.aws_cloudfront_cache_policy.cachingdisabled.id
caching_optimized = data.aws_cloudfront_cache_policy.cachingoptimized.id
acm_certificate_arn = data.aws_ssm_parameter.acm_certificate_arn.value
}