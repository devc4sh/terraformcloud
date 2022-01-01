terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "c4sh"

    workspaces {
      name = "terraformcloud"
    }
  }
}

data "vault_aws_access_credentials" "tfc" {
  backend = "~"
  role    = "tfc"
}