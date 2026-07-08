# terraform-vault-add-gitlab-project-access

Workload-layer module that onboards one GitLab project as a Vault identity entity, alias, and JWT login role.

## Layer

Workload. This module creates identity and login, but no secret policy grants.

## Prerequisites

- GitLab trust module already provisioned (`terraform-vault-gitlab-onboarding`) for the same `gitlab_instance_name`
- Stable GitLab `project_id` and `project_path` values

## Discovered values

This module no longer takes the trust mount path or accessor as inputs. Both are resolved from `gitlab_instance_name`:

- `jwt_auth_path` is derived as `jwt-gitlab/<gitlab_instance_name>`, matching the path the trust module mounts.
- The JWT mount accessor is discovered at plan time with the `vault_auth_backend` data source on that path.

## Inputs

| Name | Type | Description |
|---|---|---|
| `gitlab_instance_name` | `string` | One of `cloud`, `dedicated_prod`, `dedicated_dev` |
| `workload_name` | `string` | Workload identifier, regex validated |
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
| `workload_name` | Echo |

## No-code notes

- Alias and `user_claim` use stable `project_id`.
- `token_policies` on the workload login role is intentionally empty.
- Policy grants are attached later through use-case identity groups.

## No-code provisioning

This module is no-code enabled in the `hc-ric-demo` private registry (pinned to `0.1.0`). Click **Provision workspace**, pick a project and workspace name, then complete the form. `gitlab_instance_name` is presented as a **dropdown** limited to `cloud`, `dedicated_prod`, `dedicated_dev`. The trust mount path and accessor are derived from `gitlab_instance_name`, so they are no longer form fields.

> **No-code UX note:** The `gitlab_instance_name` dropdown is driven by explicit no-code `variable-options` configured on the module in the registry, not by the module's `contains()` validation (which only validates on submit). These options (`cloud`, `dedicated_prod`, `dedicated_dev`) are a registry-side setting applied via the `tfe_no_code_module` resource or the no-code modules API. They are not stored in this repository, so re-enabling no-code provisioning for the module requires re-applying them.

Form fields:

| Field | Required | Notes |
|---|---|---|
| `gitlab_instance_name` | yes | Dropdown: `cloud` / `dedicated_prod` / `dedicated_dev` |
| `workload_name` | yes | Workload identifier |
| `gitlab_project_id` | yes | Numeric project ID |
| `gitlab_project_path` | yes | `group/project` claim |

## Registry usage

```hcl
module "add_gitlab_project" {
  source  = "app.terraform.io/<org>/add-gitlab-project-access/vault"
  version = "~> 0.1.0"

  gitlab_instance_name = "cloud"
  workload_name        = "billing-ci"
  gitlab_project_id    = "48261734"
  gitlab_project_path  = "group/billing-service"
  bound_audiences      = ["https://vault.example.com"]
}
```

Next step in chain: use-case modules consume `entity_id`.
