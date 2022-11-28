resource "aws_ssm_parameter" "keycloak_password" {
  name        = "${var.git}-${random_string.identifier.result}-keycloak-password"
  description = "Default Keycloak admin password"
  type        = "SecureString"
  value       = random_password.shared_keycloak.result
  tags        = merge(local.tags, var.tags)
}
/*
resource "aws_ssm_parameter" "database" {
  name        = "${var.git}-${random_string.identifier.result}-database-password"
  description = "Database password"
  type        = "SecureString"
  value       = module.aurora.master_password
  tags        = var.tags
}
*/