output "auth_role_name" {
  description = "JWT login role name used by GitLab pipeline login."
  value       = vault_jwt_auth_backend_role.this.role_name
}

output "entity_id" {
  description = "Vault identity entity ID to be passed to use-case modules."
  value       = vault_identity_entity.this.id
}

output "gitlab_instance_name" {
  description = "Echo of gitlab_instance_name input."
  value       = var.gitlab_instance_name
}

output "workload_name" {
  description = "Echo of workload_name input."
  value       = var.workload_name
}
