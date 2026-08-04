resource "azurerm_monitor_metric_alert" "cpu" {

  name = var.name


  resource_group_name = var.resource_group_name


  scopes = [
    var.resource_id
  ]


  description = "CPU utilization alert"


  severity = 2


  criteria {

    metric_namespace = "Microsoft.Compute/virtualMachines"

    metric_name = "Percentage CPU"

    aggregation = "Average"

    operator = "GreaterThan"

    threshold = 80

  }


  action {

    action_group_id = var.action_group_id

  }

}