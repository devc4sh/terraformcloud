variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY_ID" {}

provider "aws" {
  access_key = "./tfvars"
  secret_key = var.AWS_SECRET_ACCESS_KEY_ID
  region     = ap-northeast-2
}

provider "vault" {
  address = "~"
}