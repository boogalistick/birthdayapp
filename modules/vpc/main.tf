resource "aws_vpc" "birthday_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
}

resource "aws_subnet" "birthday_public_subnet" {
  vpc_id            = aws_vpc.birthday_vpc.id
  cidr_block        = var.cidr_block_public
  availability_zone = "${var.aws_region}a"
}

# resource "aws_subnet" "public_b" {
#     vpc_id = "${aws_vpc.vpc_example_app.id}"
#     cidr_block = "10.0.2.0/24"
#     availability_zone = "${var.aws_region}b"
# }

resource "aws_internet_gateway" "birthday_internet_gateway" {
  vpc_id = aws_vpc.birthday_vpc.id
}

resource "aws_route" "birthday_internet_access" {
  route_table_id         = aws_vpc.birthday_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.birthday_internet_gateway.id
}

resource "aws_security_group" "birthday_security_group" {
  name        = var.birthday_security_group_name
  description = "Allow TLS inbound traffic on port 8080, 8081"
  vpc_id      = aws_vpc.birthday_vpc.id
}

resource "aws_security_group_rule" "birthday_ingress_from_web1" {
  security_group_id = aws_security_group.birthday_security_group.id
  type              = "ingress"
  description       = "ingress from the web"
  from_port         = 8080
  to_port           = 8081
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "birthday_ssh_ingress_from_web1" {
  security_group_id = aws_security_group.birthday_security_group.id
  type              = "ingress"
  description       = "ssh ingress from the web"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "birthday_egress_to_web" {
  security_group_id = aws_security_group.birthday_security_group.id
  type              = "egress"
  description       = "egress to the web"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}