output "backend_pool_id" {
  description = "The ID of the Load Balancer Backend Address Pool."
  value       = azurerm_lb_backend_address_pool.sre_demo_lb_pool.id
}

output "public_ip_id" {
  description = "The ID of the Public IP."
  value       = azurerm_public_ip.sre_demo_lb_pip.id
}
