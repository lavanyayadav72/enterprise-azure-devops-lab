resource "azurerm_network_security_rule" "this" {

  for_each = {
    for rule in var.security_rules :
    rule.name => rule
  }


  name = each.value.name

  priority = each.value.priority

  direction = each.value.direction

  access = each.value.access

  protocol = each.value.protocol


  resource_group_name = var.resource_group_name


  network_security_group_name = azurerm_network_security_group.this.name


  source_port_range = each.value.source_port_range


  destination_port_range = each.value.destination_port_range


  source_address_prefix = each.value.source_address_prefix


  destination_address_prefix = each.value.destination_address_prefix
}