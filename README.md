# terraform-vault-add-gitlab-project-access

Principal-layer module that onboards one GitLab project as a Vault identity entity, alias, and JWT login role.

## Layer

Principal. This module creates identity and login, but no secret policy grants.

## Prerequisites

- GitLab trust module already provisioned (`jwt_auth_path`, `jwt_mount_accessor`)
- Stable GitLab `project_id` and `project_path` values

## Inputs

| Name | Type | Description |
|---|---|---|
| `gitlab_instance_name` | `string` | One of `cloud`, `dedicated_prod`, `dedicated_dev` |
| `principal_name` | `string` | Principal identifier, regex validated |
| `jwt_auth_path` | `string` | Trust mount path |
| `jwt_mount_accessor` | `string` | Trust mount accessor |
| `gitlab_project_id` | `string` | Stable project ID used as alias name |
| `gitlab_project_path` | `string` | Bound claim value (`group/project`) |
| `bound_audiences` | `list(string)` | JWT role bound audiences, default `["vault"]` |
| `token_ttl` | `number` | JWT role TTL in seconds, default `3600` |
| `token_max_ttl` | `number` | JWT role max TTL in seconds, default `86400` |

## Outputs

| Name | Description |
|---|---|
| `entity_id` | Entity ID for downstream use-case modules |
| `auth_role_name` | JWT role name used by pipeline login |
| `gitlab_instance_name` | Echo |
| `principal_name` | Echo |

## No-code notes

- Alias and `user_claim` use stable `project_id`.
- `token_policies` on the principal login role is intentionally empty.
- Policy grants are attached later through use-case identity groups.

## Registry usage

```hcl
module "add_gitlab_project" {
  source  = "app.terraform.io/<org>/add-gitlab-project-access/vault"
  version = "~> 0.1"

  gitlab_instance_name = "cloud"
  principal_name      = "billing-ci"
  jwt_auth_path       = "jwt-gitlab/cloud"
  jwt_mount_accessor  = "auth_jwt_87654321"
  gitlab_project_id   = "48261734"
  gitlab_project_path = "group/billing-service"
  bound_audiences     = ["https://vault.example.com"]
}
```

Next step in chain: use-case modules consume `entity_id`.
