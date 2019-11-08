
terraform {
    backend "azurerm" {
        resource_group_name   = "terraform-backend"
        storage_account_name  = "s57adcc5b7f"
        container_name        = "backend"
        key                   = "aks.cluster.tfstate"
    }
}
