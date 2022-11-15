resource "aws_ssm_parameter" "shared_keycloak" {
  name        = "${var.git}-shared-keycloak"
  description = "Default Keycloak admin password"
  type        = "SecureString"
  value       = random_password.shared-keycloak.result
  tags        = merge(local.tags, var.tags)
}
