output "keycloak_admin_password" {
  description = "keycloak admin password"
  value       = random_password.shared_keycloak.result
  sensitive   = true
}
