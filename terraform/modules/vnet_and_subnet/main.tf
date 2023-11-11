resource "azurerm_virtual_network" "Project-Aurora_vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "Project-Aurora_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Project-Aurora_vnet.name
  address_prefixes     = var.subnet_address_prefixes
}
