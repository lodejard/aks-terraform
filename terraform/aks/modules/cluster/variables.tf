
variable "resource_group" {
    type = object({
        location = string
        name = string
    }) 
}

variable "kubernetes_version" {
  type = string
  default = "1.15.4"
}

variable "service_principal" {
    type = object({
        client_id = string
        client_secret = string
    }) 
}

variable "log_analytics_workspace_id" {
  type = string
}
