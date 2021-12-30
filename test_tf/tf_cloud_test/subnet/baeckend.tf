terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "c4sh"

    workspaces {
      name = "subnet"
    }
  }
}