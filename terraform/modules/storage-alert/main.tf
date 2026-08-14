resource "azurerm_monitor_metric_alert" "this" {

  name = var.name


  resource_group_name = var.resource_group_name


  scopes = [
    var.storage_account_id
  ]


  description = "Storage availability alert"


  severity = 2


  criteria {

    metric_namespace = "Microsoft.Storage/storageAccounts"

    metric_name = "Availability"

    aggregation = "Average"

    operator = "LessThan"

    threshold = 99

  }


  action {

    action_group_id = var.action_group_id

  }

}