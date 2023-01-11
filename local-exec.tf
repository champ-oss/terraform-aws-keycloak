resource "null_resource" "exec_create_client_script" {

  provisioner "local-exec" {

    command     = "sleep 300 && chmod +x ${path.module}/create-client.sh;${path.module}/create-client.sh"
    interpreter = ["bash", "-c"]
    environment = {
      KC_HOSTNAME             = "https://${local.keycloak_dns_name}"
      KEYCLOAK_ADMIN          = var.keycloak_admin_user
      KEYCLOAK_ADMIN_PASSWORD = aws_ssm_parameter.keycloak_password.name
      KEYCLOAK_CLIENT_ID      = "terraform-client"
      KEYCLOAK_CLIENT_SECRET  = random_password.keycloak_client_secret.result
    }
  }
  depends_on = [module.keycloak]
}
