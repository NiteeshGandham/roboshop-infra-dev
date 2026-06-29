module "vpc" {
    source = "../../terraform-vpc-creation"
    project = var.project
    environment = var.environment
    is_vpc_peering_required = true
    vpc_tags = {
        team = "DevOps"
    }
    
    public_subnet_tags = {
        team = "DevOps team"
    }

    private_subnet_tags = {
        team = "DevOps team"
    }

    database_subnet_tags = {
        team = "DevOps team"
    }
}