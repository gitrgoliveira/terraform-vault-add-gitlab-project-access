mock_provider "vault" {}

run "defaults_plan_succeeds" {
  command = plan

  variables {
    bound_audiences     = ["vault"]
    cluster_name        = "dev-cluster"
    gitlab_project_id   = "12345"
    gitlab_project_path = "group/project"
    jwt_auth_path       = "jwt/dev-cluster"
    jwt_mount_accessor  = "auth_jwt_deadbeef"
    principal_name      = "payments"
  }

  assert {
    condition     = output.cluster_name == "dev-cluster"
    error_message = "cluster_name output should echo input."
  }

  assert {
    condition     = output.principal_name == "payments"
    error_message = "principal_name output should echo input."
  }

  assert {
    condition     = output.auth_role_name == "dev-cluster-payments"
    error_message = "auth_role_name should be derived as <cluster_name>-<principal_name>."
  }
}
