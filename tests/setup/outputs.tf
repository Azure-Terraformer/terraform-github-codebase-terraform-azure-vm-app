output "repository_name_suffix" {
  value = random_string.repository_name.result
}
output "repository_name" {
  value = github_repository.main.name
}