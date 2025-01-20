variable "repository" {
  type        = string
  description = <<DESCRIPTION
The name of the GitHub repository where the Azure Function Core environment configurations will be managed.

This repository will store the Terraform configuration files and GitHub Actions workflows necessary for provisioning and managing the Azure infrastructure.
DESCRIPTION
}
variable "branch" {
  type        = string
  description = <<DESCRIPTION
The branch of the GitHub repository where the configuration files will be committed.

Ensure that the specified branch exists in the repository and that the commit user has the necessary permissions to push changes to it.
DESCRIPTION
}
variable "packer_path" {
  type        = string
  default     = "src/packer"
  description = <<DESCRIPTION
The file system path within the repository where the Terraform configuration files and workflows will be stored.

This path determines the directory structure in the repository, organizing configuration files for better manageability.
DESCRIPTION
}
variable "terraform_path" {
  type        = string
  default     = "src/terraform"
  description = <<DESCRIPTION
The file system path within the repository where the Terraform configuration files and workflows will be stored.

This path determines the directory structure in the repository, organizing configuration files for better manageability.
DESCRIPTION
}
variable "commit_user" {
  type = object({
    name  = string
    email = string
  })
  description = <<DESCRIPTION
The GitHub identity used to commit the workflow YAML file to the repository.

This includes:
- **name**: The name of the user committing the workflow file.
- **email**: The email address of the user committing the workflow file.

Ensure that the provided Git identity has the necessary permissions to push changes to the specified repository and branch.
DESCRIPTION
}
variable "primary_location" {
  type        = string
  description = <<DESCRIPTION
The primary Azure region where the resources will be deployed.

**Examples**: `eastus`, `westeurope`, `southeastasia`

Selecting an appropriate primary location is crucial for optimizing latency, compliance, and availability of your Azure resources.
DESCRIPTION
}
variable "image_names" {
  type = list(string)
}
variable "vm_size" {
  type = string
}
variable "packer_version" {
  type = string
}
variable "base_address_space" {
  type = string
}
