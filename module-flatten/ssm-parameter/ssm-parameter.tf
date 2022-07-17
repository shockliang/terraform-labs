locals {
  parameters = flatten([
    for parameters in var.parameters : [
      for keyvalue in parameters.parameters :
      {
        "name"  = "${parameters.prefix}/${keyvalue.name}",
        "value" = keyvalue.value
      }]
    ])
}

resource "aws_ssm_parameter" "parameter" {
  for_each = { for keyvalue in local.parameters : keyvalue.name => keyvalue.value }
  name     = each.key
  type     = "String"
  value    = each.value
}
