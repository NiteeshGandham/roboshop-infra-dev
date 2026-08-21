variable "components" {
    default = {
        #backend component components are attached to backend alb 
        catalogue = {
            rule_prority = 10
        }
        user = {
            rule_prority = 20
        }
        cart = {
            rule_prority = 30
        }
        shipping = {
            rule_prority = 40
        }
        payment = {
            rule_prority = 50
        }

         #frontend component components are attached to frontend alb, there is only one component there

        frontend = {
            rule_prority = 10
        }
    }
}