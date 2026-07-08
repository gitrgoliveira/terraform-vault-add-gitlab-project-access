variable "bound_audiences" {
  type        = list(string)
  description = "Bound audiences for the workload JWT login role."
  default     = ["vault"]
}

variable "gitlab_instance_name" {
  type        = string
  description = "GitLab instance scope used in trust mount naming. Must match the gitlab_instance_name used in the gitlab-onboarding trust module."

  validation {
    condition     = contains(["cloud", "dedicated_prod", "dedicated_dev"], var.gitlab_instance_name)
    error_message = "gitlab_instance_name must be one of: cloud, dedicated_prod, dedicated_dev."
  }
}

variable "gitlab_project_id" {
  type        = string
  description = "GitLab project numeric ID used as stable alias name and user claim."
}

variable "gitlab_project_path" {
  type        = string
  description = "GitLab project path (group/project) used in bound_claims."
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
