locals {
    ami_id = data.aws_ami.joindevops.id
    database_subnet_id = split(",", data.aws_ssm_parameter.database_subnet_id.value)[0]   
    mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
    tags = {
        Name = "${var.project}-${var.environment}"
        environment = var.environment
        terraform = "true"
    }
}
