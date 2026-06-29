# Changelog

All notable changes to this project are documented in this file.

## [0.0.3] - 2026-06-29

### Changed
- Renamed `gitlab_instance` to `gitlab_instance_name` and restricted values to `cloud`, `dedicated_prod`, `dedicated_dev`.

## [0.0.2] - 2026-06-29

### Changed
- Renamed `cluster_name` input/output to `gitlab_instance` to match the renamed `terraform-vault-gitlab-onboarding` trust module. Breaking change for v0.0.1 consumers.

## [0.0.1]

### Added
- Initial no-code-ready module implementation.
