
resource "random_id" "main" {
    byte_length = 5
}

resource "tls_private_key" "linux_profile" {
    algorithm = "RSA"
}

resource "random_password" "windows_profile" {
    length = 96
}

resource "azurerm_kubernetes_cluster" "main" {
    name                = "cluster-${lower(random_id.main.hex)}"
    location            = "${var.resource_group.location}"
    resource_group_name = "${var.resource_group.name}"
    dns_prefix = "aks-example-${lower(random_id.main.hex)}"
    kubernetes_version = "1.15.4"

    service_principal {
        client_id = "${var.service_principal.client_id}"
        client_secret = "${var.service_principal.client_secret}"
    }

    enable_pod_security_policy = false

    role_based_access_control {
        enabled = true
        # azure_active_directory {
        #     client_app_id = "${azuread_application.client.application_id}"
        #     server_app_id  = "${azuread_application.server.application_id}"
        #     server_app_secret = "${azuread_service_principal_password.server.value}"
        #     tenant_id = "${data.azurerm_subscription.current.tenant_id}"
        # }
    }

    addon_profile {
        oms_agent {
            enabled = true
            log_analytics_workspace_id = "${var.log_analytics_workspace_id}"
        }
    }

    network_profile {
        network_plugin = "azure"
    }

    windows_profile {
        admin_username = "AzureUser"
        admin_password = "${random_password.windows_profile.result}"
    }

    linux_profile {
        admin_username = "AzureUser"
        ssh_key {
            key_data = "${tls_private_key.linux_profile.public_key_openssh}"
        }
    }

    agent_pool_profile {
        name            = "pool1"
        type            = "VirtualMachineScaleSets"
        vm_size         = "Standard_D2_v2"
        os_type         = "Linux"
        os_disk_size_gb = 30

        enable_auto_scaling = true
        count           = 3
        min_count       = 3
        max_count       = 100
    }

    agent_pool_profile {
        name            = "pool2"
        type            = "VirtualMachineScaleSets"
        vm_size         = "Standard_D2_v2"
        os_type         = "Windows"
        os_disk_size_gb = 30

        enable_auto_scaling = true
        count           = 3
        min_count       = 3
        max_count       = 100
    }

    agent_pool_profile {
        name            = "pool3"
        type            = "VirtualMachineScaleSets"
        vm_size         = "Standard_D2_v2"
        os_type         = "Windows"
        os_disk_size_gb = 30

        enable_auto_scaling = true
        count           = 3
        min_count       = 3
        max_count       = 100
    }
    
    agent_pool_profile {
        name            = "pool4"
        type            = "VirtualMachineScaleSets"
        vm_size         = "Standard_D2_v2"
        os_type         = "Windows"
        os_disk_size_gb = 30

        enable_auto_scaling = true
        count           = 3
        min_count       = 3
        max_count       = 100
    }
}

# resource "kubernetes_namespace" "falcon_system" {
#     metadata {
#         name = "falcon-system"
#     }
# }

# resource "kubernetes_service_account" "tiller" {
#     metadata {
#         name = "tiller"
#         namespace = "falcon-system"
#     }
# }

# resource "kubernetes_cluster_role_binding" "tiller" {
#   metadata {
#     name = "falcon-system-tiller"
#   }
#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "ClusterRole"
#     name      = "cluster-admin"
#   }
#   subject {
#     kind      = "ServiceAccount"
#     name      = "tiller"
#     namespace = "falcon-system"
#   }
# }