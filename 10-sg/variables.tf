variable "project" {
    type = string
    default = "roboshop"
}

variable "environment" {
    type = string
    default = "dev"
}


variable "sg_names" {
    type = list
    default = [
        #database
        "mongodb", "redis", "mysql", "rabbitmq", 
        #backend
        "catalogue", "user", "cart", "payment", "shipping",
        #backend ALB
        "backend_alb",
        #frontend
        "frontend",
        #frontend ALB
        "frontend_alb",
        "Bastion"
         ]
}