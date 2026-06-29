mock_provider "vault" {}

run "defaults_plan_succeeds" {
  command = plan

  variables {
    bound_audiences      = ["vault"]
    gitlab_instance_name = "cloud"
    gitlab_project_id    = "12345"
    gitlab_project_path  = "group/project"
    principal_name       = "payments"
  }

  assert {
    condition     = output.gitlab_instance_name == "cloud"
    error_message = "gitlab_instance_name output should echo input."
  }

  assert {
    condition     = output.principal_name == "payments"
    error_message = "principal_name output should echo input."
  }

  assert {
    condition     = output.auth_role_name == "cloud-payments"
    error_message = "auth_role_name should be derived as <gitlab_instance_name>-<principal_name>."
  }
}
