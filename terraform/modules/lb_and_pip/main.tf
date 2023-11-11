resource "azurerm_public_ip" "Project-Aurora_lb_pip" {
  name                = var.pip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.pip_allocation_method
  sku                 = var.lb_sku
}

resource "azurerm_lb" "Project-Aurora_lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.lb_sku

  frontend_ip_configuration {
    name                 = var.frontend_config_name
    public_ip_address_id = azurerm_public_ip.Project-Aurora_lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "Project-Aurora_lb_pool" {
  name            = var.backend_pool_name
  loadbalancer_id = azurerm_lb.Project-Aurora_lb.id
}

resource "azurerm_lb_probe" "Project-Aurora_lb_probe" {
  name                = var.probe_name
  loadbalancer_id     = azurerm_lb.Project-Aurora_lb.id
  port                = var.probe_port
  protocol            = var.probe_protocol
  request_path        = var.probe_request_path
  interval_in_seconds = var.probe_interval
  number_of_probes    = var.probe_count
}

resource "azurerm_lb_rule" "Project-Aurora_lb_rule" {
  name                           = var.rule_name
  loadbalancer_id                = azurerm_lb.Project-Aurora_lb.id
  protocol                       = var.rule_protocol
  frontend_port                  = var.rule_frontend_port
  backend_port                   = var.rule_backend_port
  frontend_ip_configuration_name = var.frontend_config_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.Project-Aurora_lb_pool.id]
  probe_id                       = azurerm_lb_probe.Project-Aurora_lb_probe.id
}
