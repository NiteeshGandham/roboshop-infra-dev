locals {
    ami_id = data.aws_ami.joindevops.id
    private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_id.value)[0]   
    catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
    backend_alb_listner_arn = data.aws_ssm_parameter.backend_alb_listner_arn.value
     vpc_id = data.aws_ssm_parameter.vpc_id.value
    tags = {
        Name = "${var.project}-${var.environment}"
        environment = var.environment
        terraform = "true"
    }
}
