

output "application_id" {
  value = "${azuread_service_principal.main.application_id}"
}

output "secret" {
  value = "${azuread_service_principal_password.main.value}"
}
