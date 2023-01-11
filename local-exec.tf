resource "null_resource" "exec_create_client_script" {

  provisioner "local-exec" {

    command = "echo ${path.module};chmod +x ${path.module}/create-client.sh;${path.module}/create-client.sh"
    interpreter = ["bash", "-c"]
    environment = {
      KC_HOSTNAME             = local.keycloak_dns_name
      KEYCLOAK_ADMIN          = var.keycloak_admin_user
      KEYCLOAK_ADMIN_PASSWORD = "true"
      KEYCLOAK_CLIENT_ID      = "admin-cli"
      KEYCLOAK_CLIENT_SECRET  = random_password.keycloak_client_secret.result
    }
  }
  depends_on = [module.keycloak]
}