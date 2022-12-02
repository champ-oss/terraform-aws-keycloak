resource "aws_ssm_parameter" "keycloak_password" {
  name        = "${var.git}-${random_string.identifier.result}-keycloak-password"
  description = "Default Keycloak admin password"
  type        = "SecureString"
  value       = random_password.shared_keycloak.result
  tags        = merge(local.tags, var.tags)
}
