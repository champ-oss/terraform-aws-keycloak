resource "keycloak" "exec-create-client-script" {

  provisioner "local-exec" {

    command = "/bin/bash sleep 30 && create-client.sh"
    environment = {
      KC_HOSTNAME = local.keycloak_dns_name
      KEYCLOAK_ADMIN = var.keycloak_admin_user
      KEYCLOAK_ADMIN_PASSWORD = "true"
      KEYCLOAK_CLIENT_ID = "admin-cli"
      KEYCLOAK_CLIENT_SECRET = random_password.keycloak_client_secret.result
    }
  }
  depends_on = [module.keycloak]
}