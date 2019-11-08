

resource "kubernetes_namespace" "falcon_system" {
    metadata {
        name = "falcon-system"
    }
}

resource "kubernetes_service_account" "tiller" {
    metadata {
        name = "tiller"
        namespace = "falcon-system"
    }
}

resource "kubernetes_cluster_role_binding" "tiller" {
  metadata {
    name = "falcon-system-tiller"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "tiller"
    namespace = "falcon-system"
  }
}

module "prometheus" {
  source = "../../modules/chart_prometheus"
}
