
output "location" {
  value = "${data.terraform_remote_state.cluster.outputs.location}"
}
