
provider "kubernetes" {
    version = "~> 1.9"
    load_config_file = false
    insecure = false
    host                   = "${data.terraform_remote_state.cluster.outputs.kube_config.0.host}"
    username               = "${data.terraform_remote_state.cluster.outputs.kube_config.0.username}"
    password               = "${data.terraform_remote_state.cluster.outputs.kube_config.0.password}"
    client_certificate     = "${base64decode(data.terraform_remote_state.cluster.outputs.kube_config.0.client_certificate)}"
    client_key             = "${base64decode(data.terraform_remote_state.cluster.outputs.kube_config.0.client_key)}"
    cluster_ca_certificate = "${base64decode(data.terraform_remote_state.cluster.outputs.kube_config.0.cluster_ca_certificate)}"
}

provider "helm" {
    version = "~> 0.10"
    max_history = 200
    install_tiller = true
    namespace = "${kubernetes_namespace.falcon_system.metadata[0].name}"
    service_account = "${kubernetes_service_account.tiller.metadata[0].name}"
    override = [
        "spec.template.spec.nodeSelector.beta\\.kubernetes\\.io/os=linux"
    ]
    kubernetes {
        load_config_file = false
        insecure = false
        host                   = "${data.terraform_remote_state.cluster.outputs.kube_config.0.host}"
        username               = "${data.terraform_remote_state.cluster.outputs.kube_config.0.username}"
        password               = "${data.terraform_remote_state.cluster.outputs.kube_config.0.password}"
        client_certificate     = "${base64decode(data.terraform_remote_state.cluster.outputs.kube_config.0.client_certificate)}"
        client_key             = "${base64decode(data.terraform_remote_state.cluster.outputs.kube_config.0.client_key)}"
        cluster_ca_certificate = "${base64decode(data.terraform_remote_state.cluster.outputs.kube_config.0.cluster_ca_certificate)}"
    }
}
