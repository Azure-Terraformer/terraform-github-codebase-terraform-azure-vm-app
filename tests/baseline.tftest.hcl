run "setup" {
  module {
    source = "./tests/setup"
  }
}

run "environment" {
  module {
    source = "./"
  }

  variables {
    repository     = run.setup.repository_name
    branch         = "main"
    terraform_path = "src/terraform"
    packer_path    = "src/packer"
    commit_user = {
      name  = run.setup.github_name
      email = run.setup.github_email
    }
    image_names = [
      "atat-image1",
      "atat-image2"
    ]
    primary_location    = "eastus2"
    vm_size             = "Standard_DS2_v2"
    resource_group_name = "rg-packer"
  }

}
