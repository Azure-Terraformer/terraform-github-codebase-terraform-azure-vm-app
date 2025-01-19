locals {
  packer_folder_files = [
    "azure.pkr.hcl",
    "build.pkr.hcl",
    "locals.pkr.hcl",
    "plugins.pkr.hcl",
    "variables.pkr.hcl"
  ]
  packer_files_foreach_image = {
    for entry in flatten([
      for folder in var.image_names : [
        for file in local.packer_folder_files : {
          target = format("%s/%s", folder, file)
          source = file
        }
      ]
    ]) : entry.target => entry.source
  }
}

resource "github_repository_file" "packer_folder" {

  for_each = local.packer_files_foreach_image

  repository          = var.repository
  branch              = var.branch
  file                = "${var.packer_path}/${each.key}"
  content             = file("${path.module}/files/src/packer/${each.value}.t4")
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}

resource "github_repository_file" "packer_pkrvars" {

  for_each = toset(var.image_names)

  repository = var.repository
  branch     = var.branch
  file       = "${var.packer_path}/${each.key}/variables.pkrvars.hcl"
  content = templatefile("${path.module}/files/src/packer/variables.pkrvars.hcl.t4",
    {
      image_name          = each.key
      primary_location    = var.primary_location
      vm_size             = var.vm_size
      resource_group_name = var.resource_group_name
    }
  )
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}
