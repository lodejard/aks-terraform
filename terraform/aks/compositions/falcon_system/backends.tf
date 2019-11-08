
terraform {
    backend "azurerm" {
        resource_group_name   = "terraform-backend"
        storage_account_name  = "s57adcc5b7f"
        container_name        = "backend"
        key                   = "aks.falcon-system.tfstate"
    }
}

data "terraform_remote_state" "cluster" {
    backend = "azurerm"

    config = {
        resource_group_name   = "terraform-backend"
        storage_account_name  = "s57adcc5b7f"
        container_name        = "backend"
        key                   = "aks.cluster.tfstate"
    }

    workspace = "${terraform.workspace}"
}
