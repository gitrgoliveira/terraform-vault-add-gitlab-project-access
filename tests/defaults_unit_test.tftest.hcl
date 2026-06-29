mock_provider "vault" {}

run "defaults_plan_succeeds" {
  command = plan

  variables {
    bound_audiences     = ["vault"]
    gitlab_instance     = "dev-cluster"
    gitlab_project_id   = "12345"
    gitlab_project_path = "group/project"
    jwt_auth_path       = "jwt/dev-cluster"
    jwt_mount_accessor  = "auth_jwt_deadbeef"
    principal_name      = "payments"
  }

  assert {
    condition     = output.gitlab_instance == "dev-cluster"
    error_message = "gitlab_instance output should echo input."
  }

  assert {
    condition     = output.principal_name == "payments"
    error_message = "principal_name output should echo input."
  }

  assert {
    condition     = output.auth_role_name == "dev-cluster-payments"
    error_message = "auth_role_name should be derived as <gitlab_instance>-<principal_name>."
  }
}
