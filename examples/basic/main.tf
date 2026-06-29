terraform {
  required_version = ">= 1.9"
}

locals {
  trust_bound_audiences = ["https://vault.example.com"]
  trust_gitlab_instance = "cloud"
}

module "add_gitlab_project" {
  source = "../../"

  bound_audiences      = local.trust_bound_audiences
  gitlab_instance_name = local.trust_gitlab_instance
  gitlab_project_id    = var.gitlab_project_id
  gitlab_project_path  = var.gitlab_project_path
  principal_name       = var.principal_name
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
