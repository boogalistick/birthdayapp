output "subnet_security_group" {
  value = aws_security_group.birthday_security_group.*.id
}

output "subnet_id" {
  value = aws_subnet.birthday_public_subnet.id
}