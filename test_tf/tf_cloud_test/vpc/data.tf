data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "c4sh"
    workspaces = {
      name = "terraformcloud"
    }
  }
}