
output "resource_group_name" {
  value = "${azurerm_resource_group.main.name}"
}

output "storage_account_name" {
  value = "${azurerm_storage_account.main.name}"
}

output "storage_account_key" {
  value = "${azurerm_storage_account.main.primary_access_key}"
  sensitive   = true
}
