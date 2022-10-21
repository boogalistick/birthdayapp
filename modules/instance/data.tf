data "aws_ami" "amazon_linux_ec2" {
  most_recent = var.most_recent_ami
  owners      = ["${var.ami_owner}"]

  filter {
    name   = "name"
    values = ["${var.birthday_ami_family}"]
  }
}