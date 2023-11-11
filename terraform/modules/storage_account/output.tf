output "storage_account_id" {
  description = "The ID of the Storage Account."
  value       = azurerm_storage_account.Project-Aurora_sa.id
}

output "primary_blob_endpoint" {
  description = "The Primary Blob Endpoint for the Storage Account."
  value       = azurerm_storage_account.Project-Aurora_sa.primary_blob_endpoint
}
