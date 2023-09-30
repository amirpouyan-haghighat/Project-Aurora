resource "azurerm_virtual_network" "sre_demo_vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "sre_demo_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.sre_demo_vnet.name
  address_prefixes     = var.subnet_address_prefixes
}
