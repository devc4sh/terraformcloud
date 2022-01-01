variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  secret_key = var.access_key
  access_key = var.secret_key
  region     = ap-northeast-2
}