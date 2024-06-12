output "keycloak_endpoint" {
  description = "keycloak endpoint url"
  value       = var.enable_cluster ? "https://${module.keycloak_cluster[0].dns_name}" : "https://${module.keycloak_local[0].dns_name}"
}

output "keycloak_admin_password" {
  description = "keycloak admin pw"
  value       = random_password.shared_keycloak.result
  sensitive   = true
}