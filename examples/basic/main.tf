terraform {
  required_version = ">= 1.9"
}

locals {
  trust_bound_audiences = ["https://vault.example.com"]
  trust_cluster_name    = "ocp-prod-eu"
  trust_jwt_auth_path   = "jwt-gitlab/ocp-prod-eu"
  trust_mount_accessor  = "auth_jwt_87654321"
}

module "add_gitlab_project" {
  source = "../../"

  bound_audiences     = local.trust_bound_audiences
  cluster_name        = local.trust_cluster_name
  gitlab_project_id   = var.gitlab_project_id
  gitlab_project_path = var.gitlab_project_path
  jwt_auth_path       = local.trust_jwt_auth_path
  jwt_mount_accessor  = local.trust_mount_accessor
  principal_name      = var.principal_name
}

variable "gitlab_project_id" {
  type        = string
  description = "GitLab project numeric ID."
}

variable "gitlab_project_path" {
  type        = string
  description = "GitLab project path as group/project."
}

variable "principal_name" {
  type        = string
  description = "Principal identifier used in entity and role naming."
}
