resource "azurerm_monitor_diagnostic_setting" "this" {

  name = var.name

  target_resource_id = var.target_resource_id

  log_analytics_workspace_id = var.log_analytics_workspace_id


  enabled_log {

    category = "StorageRead"

  }


  enabled_log {

    category = "StorageWrite"

  }


  enabled_log {

    category = "StorageDelete"

  }


  enabled_metric {

    category = "Transaction"


  }

}