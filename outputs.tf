output "keycloak_endpoint" {
  description = "keycloak endpoint url"
  value       = "https://${local.keycloak_dns_name}"
}