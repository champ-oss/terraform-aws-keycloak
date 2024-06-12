output "keycloak_endpoint" {
  description = "keycloak endpoint url"
  value       = "https://${module.keycloak_cluster.dns_name}"
}

output "keycloak_admin_password" {
  description = "keycloak admin pw"
  value       = random_password.shared_keycloak.result
  sensitive   = true
}