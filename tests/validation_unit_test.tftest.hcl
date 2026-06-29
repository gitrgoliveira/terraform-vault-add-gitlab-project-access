mock_provider "vault" {}

run "invalid_principal_name_fails_validation" {
  command = plan

  variables {
    bound_audiences     = ["vault"]
    gitlab_instance     = "dev-cluster"
    gitlab_project_id   = "12345"
    gitlab_project_path = "group/project"
    jwt_auth_path       = "jwt/dev-cluster"
    jwt_mount_accessor  = "auth_jwt_deadbeef"
    principal_name      = "INVALID_NAME"
  }

  expect_failures = [
    var.principal_name,
  ]
}

run "invalid_gitlab_instance_fails_validation" {
  command = plan

  variables {
    bound_audiences     = ["vault"]
    gitlab_instance     = "-bad"
    gitlab_project_id   = "12345"
    gitlab_project_path = "group/project"
    jwt_auth_path       = "jwt/dev-cluster"
    jwt_mount_accessor  = "auth_jwt_deadbeef"
    principal_name      = "payments"
  }

  expect_failures = [
    var.gitlab_instance,
  ]
}
