provider "vault" {
  skip_child_token = true
}

locals {
  auth_role_name = "${var.gitlab_instance}-${var.principal_name}"
}

resource "vault_identity_entity" "this" {
  name = local.auth_role_name
}

resource "vault_identity_entity_alias" "this" {
  name           = var.gitlab_project_id
  mount_accessor = var.jwt_mount_accessor
  canonical_id   = vault_identity_entity.this.id
}

resource "vault_jwt_auth_backend_role" "this" {
  backend         = var.jwt_auth_path
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
