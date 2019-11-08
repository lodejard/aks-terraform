
variable "location" {
    type = "string"
    default = "eastus2"
    description = "Azure location used for resource group and created resources"
}

variable "resource_group_name" {
    type = "string"
    default = "terraform-backend"
    description = "Resource group name to hold any created resources"
}
