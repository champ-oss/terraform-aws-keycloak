output "keycloak_client_secret" {
  description = "keycloak admin password"
  value       = random_password.keycloak_client_secret.result
  sensitive   = true
}

output "keycloak_endpoint" {
  description = "keycloak endpoint url"
  value       = "https://${local.keycloak_dns_name}"
}