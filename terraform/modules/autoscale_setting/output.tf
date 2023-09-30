output "autoscale_setting_name" {
  description = "The name of the Autoscale Setting."
  value       = azurerm_monitor_autoscale_setting.sre_demo_as.name
}
