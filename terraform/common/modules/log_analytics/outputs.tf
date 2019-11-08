

output "id" {
  value = "${azurerm_log_analytics_workspace.main.id}"
}

output "workspace_id" {
  value = "${azurerm_log_analytics_workspace.main.workspace_id}"
}

output "workspace_key" {
  value = "${azurerm_log_analytics_workspace.main.primary_shared_key}"
}

output "portal_url" {
  value = "${azurerm_log_analytics_workspace.main.portal_url}"
}

