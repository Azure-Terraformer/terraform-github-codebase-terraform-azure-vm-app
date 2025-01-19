locals {
  terraform_folder_files = [
    "main.tf",
    "variables.tf",
    "versions.tf"
  ]
}

resource "github_repository_file" "terraform_folder" {

  for_each = toset(local.terraform_folder_files)

  repository          = var.repository
  branch              = var.branch
  file                = "${var.terraform_path}/${each.key}"
  content             = file("${path.module}/files/src/terraform/${each.key}.t4")
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}

resource "github_repository_file" "terraform_tfvars" {

  repository = var.repository
  branch     = var.branch
  file       = "${var.terraform_path}/terraform.tfvars"
  content = templatefile("${path.module}/files/src/terraform/terraform.tfvars.t4",
    {
      location = var.primary_location
    }
  )
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}
