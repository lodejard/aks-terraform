
resource "random_id" "main" {
  byte_length = 5
}

resource "azurerm_resource_group" "main" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "azurerm_storage_account" "main" {
  name                     = "s${lower(random_id.main.hex)}"
  resource_group_name      = "${azurerm_resource_group.main.name}"
  location                 = "${azurerm_resource_group.main.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# resource "azurerm_role_assignment" "storage_account" {
#   scope = "${azurerm_storage_account.aci_example.id}"
#   role_definition_name = "Contributor"
#   principal_id = "${azurerm_user_assigned_identity.aci_example.principal_id}"
# }

resource "azurerm_storage_container" "main" {
  name                  = "backend"
  storage_account_name  = "${azurerm_storage_account.main.name}"
  container_access_type = "private"
}
