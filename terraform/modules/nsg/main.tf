resource "azurerm_network_security_group" "Project-Aurora_nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = var.security_rule_name
    priority                   = var.security_rule_priority
    direction                  = var.security_rule_direction
    access                     = var.security_rule_access
    protocol                   = var.security_rule_protocol
    source_port_range          = var.security_rule_source_port_range
    destination_port_range     = var.security_rule_destination_port_range
    source_address_prefix      = var.security_rule_source_address_prefix
    destination_address_prefix = var.security_rule_destination_address_prefix
  }
}

resource "azurerm_subnet_network_security_group_association" "Project-Aurora_nsg_association" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.Project-Aurora_nsg.id
}
