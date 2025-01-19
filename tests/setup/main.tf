resource "random_string" "repository_name" {
  length  = 6
  special = false
  upper   = false
}


resource "github_repository" "main" {

  name        = "atat-test-${random_string.repository_name.result}"
  description = "Used by GitHub AT-AT Automated Tests"

  visibility             = "public"
  delete_branch_on_merge = true
  auto_init              = true

}

resource "github_branch" "main" {
  repository = github_repository.main.name
  branch     = "main"
}

resource "github_branch_default" "default" {
  repository = github_repository.main.name
  branch     = github_branch.main.branch
}

data "github_user" "current" {
  username = ""
}
