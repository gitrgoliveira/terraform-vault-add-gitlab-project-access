provider "vault" {
  skip_child_token = true
}

locals {
  auth_role_name = "${var.gitlab_instance_name}-${var.principal_name}"

  # The trust module (terraform-vault-gitlab-onboarding) always mounts the JWT
  # auth backend at jwt-gitlab/<gitlab_instance_name>. Derive the same path here
  # instead of requiring it as an input.
  jwt_auth_path = "jwt-gitlab/${var.gitlab_instance_name}"
}

# Discover the JWT auth mount created by the trust module so callers do not need
# to copy the mount accessor from the trust module outputs.
data "vault_auth_backend" "gitlab" {
  path = local.jwt_auth_path
}

resource "vault_identity_entity" "this" {
  name = local.auth_role_name
}

resource "vault_identity_entity_alias" "this" {
  name           = var.gitlab_project_id
  mount_accessor = data.vault_auth_backend.gitlab.accessor
  canonical_id   = vault_identity_entity.this.id
}

resource "vault_jwt_auth_backend_role" "this" {
  backend         = local.jwt_auth_path
  role_name       = local.auth_role_name
  role_type       = "jwt"
  user_claim      = "project_id"
  bound_audiences = var.bound_audiences
  token_ttl       = var.token_ttl
  token_max_ttl   = var.token_max_ttl
  token_policies  = []

  bound_claims = {
    project_path = var.gitlab_project_path
  }
}
