module "components" {
    for_each = var.components
    source = "git::https://github.com/NiteeshGandham/terraform-roboshop-component.git?ref=main"
    components = each.key
    rule_priority = each.value.rule_priority
}