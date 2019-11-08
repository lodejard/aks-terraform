
data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}

data "azuread_domains" "initial" {
    only_initial = true
}

variable "workspace_map" {
    type = "map"
    default = {
        "gme-testing-x001" = {
            location="eastus2"
            resource_group_name="aks-x001"
        }
        "gme-testing-x002" = {
            location="westus2"
            resource_group_name="aks-x002"
        }
    }
}

locals {
    lookup = "${lookup(var.workspace_map, terraform.workspace)}"
    location = "${local.lookup.location}"
    resource_group_name = "${local.lookup.resource_group_name}"
}
