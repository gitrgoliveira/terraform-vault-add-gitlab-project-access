mock_provider "vault" {}

run "invalid_principal_name_fails_validation" {
  command = plan

  variables {
    bound_audiences      = ["vault"]
    gitlab_instance_name = "cloud"
    gitlab_project_id    = "12345"
    gitlab_project_path  = "group/project"
    principal_name       = "INVALID_NAME"
  }

  expect_failures = [
    var.principal_name,
  ]
}

run "invalid_gitlab_instance_name_fails_validation" {
  command = plan

  variables {
    bound_audiences      = ["vault"]
    gitlab_instance_name = "-bad"
    gitlab_project_id    = "12345"
    gitlab_project_path  = "group/project"
    principal_name       = "payments"
  }

  expect_failures = [
    var.gitlab_instance_name,
  ]
}
