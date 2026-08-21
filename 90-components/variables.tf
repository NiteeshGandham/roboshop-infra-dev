variable "components" {
    default = {
        #backend component components are attached to backend alb 
        catalogue = {
            rule_priority = 10
        }
/*         user = {
            rule_priority = 20
        }
        cart = {
            rule_priority = 30
        }
        shipping = {
            rule_priority = 40
        }
        payment = {
            rule_priority = 50
        } */

         #frontend component components are attached to frontend alb, there is only one component there

        frontend = {
            rule_priority = 10
        }
    }
}