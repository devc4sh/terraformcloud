variable "subnet_cidrs" {}
variable "subnet_name" {}
variable "vpc_id" {}
variable "tag" {}
variable "azs" {}

resource "aws_subnet" "main" {
  count      = length(var.subnet_cidrs)
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.tag}_${var.subnet_name}_SUBNET_${substr(var.azs[count.index], -1, 1)}"
   }
}

resource "aws_route_table" "rt" {
  vpc_id     = var.vpc_id

  tags = {
    Name = "${var.tag}_${var.subnet_name}_RT"
  }
}

resource "aws_route_table_association" "rt_asso" {
  count          = length(var.subnet_cidrs)
  subnet_id      = aws_subnet.main[count.index].id
  route_table_id = aws_route_table.rt.id
}

output "subnet_ids" {
  value = aws_subnet.main.*.id
}

output "rt_id" {
  value = aws_route_table.rt.id
}

