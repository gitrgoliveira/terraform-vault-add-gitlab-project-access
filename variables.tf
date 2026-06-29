variable "bound_audiences" {
  type        = list(string)
  description = "Bound audiences for the principal JWT login role."
  default     = ["vault"]
}

variable "gitlab_instance" {
  type        = string
  description = "GitLab instance/scope identifier from trust module outputs."

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{0,30}[a-z0-9]$", var.gitlab_instance))
    error_message = "gitlab_instance must match ^[a-z][a-z0-9-]{0,30}[a-z0-9]$."
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

variable "jwt_auth_path" {
  type        = string
  description = "JWT auth backend path from trust module output."
}

variable "jwt_mount_accessor" {
  type        = string
  description = "JWT mount accessor from trust module output."
}

variable "principal_name" {
  type        = string
  description = "Short principal identifier used in entity and role naming."

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{0,30}[a-z0-9]$", var.principal_name))
    error_message = "principal_name must match ^[a-z][a-z0-9-]{0,30}[a-z0-9]$."
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
