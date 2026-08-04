locals {
  gateway_ip_configuration_name  = "gateway-ip-config"
  frontend_ip_configuration_name = "frontend-ip"
  frontend_port_name             = "http-port"
  backend_pool_name              = "web-backend-pool"
  backend_http_settings_name     = "web-http-settings"
  listener_name                  = "web-http-listener"
  routing_rule_name              = "web-routing-rule"
  probe_name                     = "web-health-probe"
}

resource "azurerm_web_application_firewall_policy" "this" {
  name                = "${var.name}-waf-policy"
  resource_group_name = var.resource_group_name
  location            = var.location

  policy_settings {
    enabled            = true
    mode               = "Prevention" # or "Detection"
    request_body_check = true
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }

  tags = var.tags
}
resource "azurerm_application_gateway" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  firewall_policy_id = azurerm_web_application_firewall_policy.this.id
  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = var.capacity
  }

  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20220101"
  }

  gateway_ip_configuration {
    name      = local.gateway_ip_configuration_name
    subnet_id = var.gateway_subnet_id
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = var.public_ip_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = var.frontend_port
  }

  backend_address_pool {
    name         = local.backend_pool_name
    ip_addresses = var.backend_ip_addresses
  }

  backend_http_settings {
    name                  = local.backend_http_settings_name
    cookie_based_affinity = "Disabled"
    port                  = var.backend_port
    protocol              = var.backend_protocol
    request_timeout       = var.request_timeout
    probe_name            = local.probe_name
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = var.frontend_protocol
  }

  request_routing_rule {
    name                       = local.routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_pool_name
    backend_http_settings_name = local.backend_http_settings_name
    priority                   = var.routing_rule_priority
  }

  probe {
    name                                      = local.probe_name
    protocol                                  = var.frontend_protocol
    host                                      = "127.0.0.1"
    path                                      = var.probe_path
    interval                                  = var.probe_interval
    timeout                                   = var.probe_timeout
    unhealthy_threshold                       = var.probe_unhealthy_threshold
    pick_host_name_from_backend_http_settings = false

    match {
      status_code = ["200-399"]
    }
  }

  tags = var.tags

}