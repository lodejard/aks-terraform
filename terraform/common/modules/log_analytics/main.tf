
resource "random_id" "main" {
  byte_length = 5
}

locals {
    suffix = "${lower(random_id.main.hex)}"
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = "analytics-${local.suffix}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
