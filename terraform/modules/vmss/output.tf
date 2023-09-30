output "vmss_id" {
  description = "The ID of the Virtual Machine Scale Set."
  value       = azurerm_virtual_machine_scale_set.sre_demo_vmss.id
}
