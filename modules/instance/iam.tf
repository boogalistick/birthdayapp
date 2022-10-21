resource "aws_iam_role" "birthday_ec2_role" {
  name = var.birthday_ec2_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

  tags = {
    project = "birthday-app"
  }
}

resource "aws_iam_instance_profile" "birthday_ec2_profile" {
  name = var.birthday_ec2_profile_name
  role = aws_iam_role.birthday_ec2_role.name
}

resource "aws_iam_role_policy" "birthday_ec2_policy" {
  name = var.birthday_ec2_policy
  role = aws_iam_role.birthday_ec2_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}