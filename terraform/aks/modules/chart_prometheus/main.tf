
data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "main" {
  name  = "prometheus-operator"
  namespace = "falcon-system"

  repository = "${data.helm_repository.stable.metadata[0].name}"
  chart = "stable/prometheus-operator"
  version = "5.14.1"
  
  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}
