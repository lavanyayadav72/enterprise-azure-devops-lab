resource "azurerm_monitor_action_group" "this" {

  name = var.name

  resource_group_name = var.resource_group_name

  short_name = "contoso"


  email_receiver {

    name = "admin"

    email_address = var.email_address

  }


  tags = var.tags

}