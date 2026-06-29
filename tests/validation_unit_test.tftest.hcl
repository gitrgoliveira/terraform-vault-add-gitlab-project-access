mock_provider "vault" {}

run "invalid_principal_name_fails_validation" {
  command = plan

  variables {
    bound_audiences     = ["vault"]
    cluster_name        = "dev-cluster"
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

run "invalid_cluster_name_fails_validation" {
  command = plan

  variables {
    bound_audiences     = ["vault"]
    cluster_name        = "-bad"
    gitlab_project_id   = "12345"
    gitlab_project_path = "group/project"
    jwt_auth_path       = "jwt/dev-cluster"
    jwt_mount_accessor  = "auth_jwt_deadbeef"
    principal_name      = "payments"
  }

  expect_failures = [
    var.cluster_name,
  ]
}
