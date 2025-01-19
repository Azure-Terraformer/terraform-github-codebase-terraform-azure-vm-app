output "repository_name_suffix" {
  value = random_string.repository_name.result
}
output "repository_name" {
  value = github_repository.main.name
}
output "github_email" {
  value = data.github_user.current.email
}
output "github_name" {
  value = data.github_user.current.name
}
