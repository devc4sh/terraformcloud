variable "subnet_id" {}
variable "tag" {}

resource "aws_nat_gateway" "main" {
  subnet_id     = var.subnet_id
  allocation_id = aws_eip.nat.id

  tags = {
    Name = "${var.tag}_NAT"
  }

  depends_on = [
    aws_eip.nat,
  ]
}

resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "${var.tag}_NAT"
  }
}

output "nat_id" {
  value = aws_nat_gateway.main.id
}