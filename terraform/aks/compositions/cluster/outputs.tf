
output "kube_config" {
  value = module.cluster.kube_config
  sensitive   = true
}

output "kube_config_raw" {
  value = module.cluster.kube_config_raw
  sensitive   = true
}

output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "location" {
  value = azurerm_resource_group.main.location
}
