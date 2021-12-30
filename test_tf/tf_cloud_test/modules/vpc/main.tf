variable "vpc_cidr" {}
variable "enable_igw" {}
variable "tag" {}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.tag}_VPC"
  }
}

resource "aws_internet_gateway" "igw" {

  count  = var.enable_igw ? 1:0
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.tag}_IGW"
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "igw_id" {
  value = try(aws_internet_gateway.igw.*.id[0], null)
}