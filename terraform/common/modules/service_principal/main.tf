


resource "azuread_application" "main" {
  name                       = "${var.application_name}"
  homepage                   = "https://${var.domain_name}/${var.application_name}"
  identifier_uris            = ["https://${var.domain_name}/${var.application_name}"]
  reply_urls                 = ["https://${var.domain_name}/${var.application_name}"]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
}

resource "random_password" "main" {
    length = 128
}

resource "azuread_service_principal" "main" {
  application_id = "${azuread_application.main.application_id}"
}

resource "azuread_service_principal_password" "main" {
  service_principal_id = "${azuread_service_principal.main.id}"
  value                = "${random_password.main.result}"
  end_date_relative    = "2160h" # 90 days
}
