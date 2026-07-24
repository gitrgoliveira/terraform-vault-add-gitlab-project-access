variable "bound_audience" {
  type        = string
  description = "JWT audience for Vault authentication."
  default     = "vault"
}

variable "gitlab_instance_name" {
  type        = string
  description = "GitLab instance scope used in trust mount naming. Must match the gitlab_instance_name used in the gitlab-onboarding trust module."

  validation {
    condition     = contains(["cloud", "dedicated-prod", "dedicated-dev"], var.gitlab_instance_name)
    error_message = "gitlab_instance_name must be one of: cloud, dedicated-prod, dedicated-dev."
  }
}

variable "gitlab_project_id" {
  type        = string
  description = "GitLab project numeric ID used as stable alias name and user claim."

  validation {
    condition     = can(regex("^[1-9][0-9]*$", var.gitlab_project_id))
    error_message = "gitlab_project_id must be a positive integer."
  }
}

variable "gitlab_project_path" {
  type        = string
  description = "GitLab project path (group/project) used in bound_claims."

  validation {
    condition     = can(regex("^[a-zA-Z0-9_./-]+/[a-zA-Z0-9_./-]+$", var.gitlab_project_path))
    error_message = "gitlab_project_path must be a valid GitLab project path (e.g. group/project)."
  }
}

variable "token_max_ttl" {
  type        = number
  description = "JWT login role token max TTL in seconds."
  default     = 86400
}

variable "token_ttl" {
  type        = number
  description = "JWT login role token TTL in seconds."
  default     = 3600
}

variable "workload_name" {
  type        = string
  description = "Short workload identifier used in entity and role naming."

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{0,30}[a-z0-9]$", var.workload_name))
    error_message = "workload_name must match ^[a-z][a-z0-9-]{0,30}[a-z0-9]$."
  }
}
