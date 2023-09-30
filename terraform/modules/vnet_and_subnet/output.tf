output "subnet_id" {
  description = "The ID of the created subnet."
  value       = azurerm_subnet.sre_demo_subnet.id
}

output "vnet_name" {
  description = "The name of the created virtual network."
  value       = azurerm_virtual_network.sre_demo_vnet.name
}
