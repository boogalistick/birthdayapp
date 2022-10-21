resource "aws_instance" "birthday_web" {
  ami           = data.aws_ami.amazon_linux_ec2.id
  instance_type = var.instance_type
  root_block_device {
    volume_size = 32
  }
  user_data                   = file("${var.docker}")
  subnet_id                   = var.birthday_public_subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = aws_key_pair.birthday_key.key_name
  vpc_security_group_ids      = var.birthday_vpc_security_group_ids

  iam_instance_profile = aws_iam_instance_profile.birthday_ec2_profile.name
}

resource "aws_eip" "birthday_eip" {
  vpc      = true
  instance = aws_instance.birthday_web.id
}

resource "aws_key_pair" "birthday_key" {
  key_name   = var.key_name
  public_key = file("${var.public_key}")
}
# resource "aws_instance" "web" {
#   ami           = data.aws_ami.amazon_linux_2.id
#   instance_type = "t3.medium"

#   root_block_device {
#     volume_size = 16
#   }

#   vpc_security_group_ids = [
#     module.ec2_sg.this_security_group_id,
#     module.dev_ssh_sg.this_security_group_id
#   ]
#   iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

#   tags = {
#     project = "hello-world"
#   }

#   key_name                = "hello-world-key"
#   monitoring              = true
#   disable_api_termination = false
#   ebs_optimized           = true
# }



 