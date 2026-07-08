# Changelog

All notable changes to this project are documented in this file.

## [0.1.0] - 2026-07-07

### Changed
- BREAKING: renamed the `principal_name` input and output to `workload_name` to align with the "workload" onboarding terminology. Consumers must update the input name and any reads of the `principal_name` output.

## [0.0.5] - 2026-06-29

### Changed
- Aligned the `gitlab_instance_name` input description with the `gitlab-onboarding` trust module. It now reads "GitLab instance scope used in trust mount naming" and clarifies the value must match the trust module, correcting the misleading "from trust module outputs" wording shown in the no-code form.

## [0.0.4] - 2026-06-29

### Changed
- Removed the `jwt_auth_path` and `jwt_mount_accessor` inputs. The mount path is now derived as `jwt-gitlab/<gitlab_instance_name>` and the mount accessor is discovered via a `vault_auth_backend` data source. Breaking change for v0.0.3 consumers.

## [0.0.3] - 2026-06-29

### Changed
- Renamed `gitlab_instance` to `gitlab_instance_name` and restricted values to `cloud`, `dedicated_prod`, `dedicated_dev`.

## [0.0.2] - 2026-06-29

### Changed
- Renamed `cluster_name` input/output to `gitlab_instance` to match the renamed `terraform-vault-gitlab-onboarding` trust module. Breaking change for v0.0.1 consumers.

## [0.0.1]

### Added
- Initial no-code-ready module implementation.
