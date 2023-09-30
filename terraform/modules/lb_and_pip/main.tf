resource "azurerm_public_ip" "sre_demo_lb_pip" {
  name                = var.pip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.pip_allocation_method
  sku                 = var.lb_sku
}

resource "azurerm_lb" "sre_demo_lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.lb_sku

  frontend_ip_configuration {
    name                 = var.frontend_config_name
    public_ip_address_id = azurerm_public_ip.sre_demo_lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "sre_demo_lb_pool" {
  name            = var.backend_pool_name
  loadbalancer_id = azurerm_lb.sre_demo_lb.id
}

resource "azurerm_lb_probe" "sre_demo_lb_probe" {
  name                = var.probe_name
  loadbalancer_id     = azurerm_lb.sre_demo_lb.id
  port                = var.probe_port
  protocol            = var.probe_protocol
  request_path        = var.probe_request_path
  interval_in_seconds = var.probe_interval
  number_of_probes    = var.probe_count
}

resource "azurerm_lb_rule" "sre_demo_lb_rule" {
  name                           = var.rule_name
  loadbalancer_id                = azurerm_lb.sre_demo_lb.id
  protocol                       = var.rule_protocol
  frontend_port                  = var.rule_frontend_port
  backend_port                   = var.rule_backend_port
  frontend_ip_configuration_name = var.frontend_config_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.sre_demo_lb_pool.id]
  probe_id                       = azurerm_lb_probe.sre_demo_lb_probe.id
}

resource "azurerm_monitor_diagnostic_setting" "sre_demo_lb_diagnostic" {
  name               = "sre-demo-lb-diagnostic-setting"
  target_resource_id = azurerm_lb.sre_demo_lb.id

  storage_account_id = var.diagnostic_storage_id

  log {
    category = "LoadBalancerAlertEvent"
    enabled  = true
  }

  log {
    category = "LoadBalancerProbeHealthStatus"
    enabled  = true
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
  depends_on = [var.dependencies]
}

