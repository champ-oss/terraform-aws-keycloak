output "keycloak_admin_password" {
  description = "keycloak admin password"
  value       = random_password.shared_keycloak.result
  sensitive   = true
}

output "keycloak_endpoint" {
  description = "keycloak endpoint url"
  value       = "https://${local.keycloak_dns_name}"
}