resource "azurerm_monitor_diagnostic_setting" "this" {


  name = var.name


  target_resource_id = var.target_resource_id


  log_analytics_workspace_id = var.workspace_id



  enabled_log {

    category = "AuditEvent"

  }



  enabled_metric {

    category = "AllMetrics"

  }

}