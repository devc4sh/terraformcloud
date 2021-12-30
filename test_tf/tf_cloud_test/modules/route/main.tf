variable "rsc_type" {}
variable "rsc_cidr" {}
variable "rt_id" {}
variable "rsc_dst" {}

resource "aws_route" "gw" {
  count = var.rsc_type == "gw" ? 1:0
  route_table_id            = var.rt_id
  destination_cidr_block    = var.rsc_cidr
  gateway_id                = var.rsc_dst
}

resource "aws_route" "nat" {
  count = var.rsc_type == "nat" ? 1:0
  route_table_id            = var.rt_id
  destination_cidr_block    = var.rsc_cidr
  nat_gateway_id            = var.rsc_dst
}

resource "aws_route" "tgw" {
  count = var.rsc_type == "tgw" ? 1:0
  route_table_id            = var.rt_id
  destination_cidr_block    = var.rsc_cidr
  transit_gateway_id        = var.rsc_dst
}

resource "aws_route" "vpce" {
  count = var.rsc_type == "vpce" ? 1:0
  route_table_id            = var.rt_id
  destination_cidr_block    = var.rsc_cidr
  vpc_endpoint_id           = var.rsc_dst
}

resource "aws_route" "pcx" {
  count = var.rsc_type == "pcx" ? 1:0
  route_table_id            = var.rt_id
  destination_cidr_block    = var.rsc_cidr
  vpc_peering_connection_id = var.rsc_dst
}

resource "aws_route" "instance" {
  count = var.rsc_type == "instance" ? 1:0
  route_table_id            = var.rt_id
  destination_cidr_block    = var.rsc_cidr
  instance_id               = var.rsc_dst
}