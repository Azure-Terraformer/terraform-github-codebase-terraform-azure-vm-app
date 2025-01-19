resource "github_repository_file" "manual" {

  for_each = toset(var.image_names)

  repository = var.repository
  branch     = var.branch
  file       = ".github/workflows/atat-manual-packer-build-${each.key}.yaml"

  content = templatefile("${path.module}/files/.github/workflows/atat-manual-packer-build-env.yaml.t4",
    {
      image_name               = each.key
      packer_working_directory = "${var.packer_path}/${each.key}"
      packer_version           = var.packer_version
    }
  )

  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}
