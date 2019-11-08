

resource "azurerm_resource_group" "main" {
  name     = "${local.resource_group_name}"
  location = "${local.location}"
}

resource "random_id" "main" {
  byte_length = 5
}

locals {
    cluster_name = "cluster-${lower(random_id.main.hex)}"
}

module "service_principal" {
  source      = "../../../common/modules/service_principal"
  domain_name = "${data.azuread_domains.initial.domains[0].domain_name}"
  application_name = "${local.cluster_name}"
}

module "log_analytics" {
  source      = "../../../common/modules/log_analytics"
  resource_group_name = azurerm_resource_group.main.name
  location = azurerm_resource_group.main.location
}

module "cluster" {
  source      = "../../modules/cluster"
  resource_group = {
    name = "${azurerm_resource_group.main.name}"
    location = "${azurerm_resource_group.main.location}"
  }
  service_principal = {
    client_id = "${module.service_principal.application_id}"
    client_secret = "${module.service_principal.secret}"
  }
  log_analytics_workspace_id = module.log_analytics.id
}
