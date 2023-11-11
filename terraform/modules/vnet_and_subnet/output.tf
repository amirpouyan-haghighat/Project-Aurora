output "subnet_id" {
  description = "The ID of the created subnet."
  value       = azurerm_subnet.Project-Aurora_subnet.id
}

output "vnet_name" {
  description = "The name of the created virtual network."
  value       = azurerm_virtual_network.Project-Aurora_vnet.name
}
