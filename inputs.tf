#Provider

variable "access_key" {
  type        = string
  description = "AWS IAM access key"
  default     = ""
}

variable "secret_key" {

  type        = string
  description = "AWS Secret access key"
  default     = ""
}
# Network

variable "aws_region" {
  type        = string
  description = "Cloud region where to build infra"
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enablement of DNS hostnames"
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  description = "Enablement of DNS support"
  default     = true
}

variable "cidr_block_public" {
  type        = string
  description = "Cidr block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "birthday_security_group_name" {
  type        = string
  description = "Instance security group name"
  default     = "birthday_public_security_group"
}

#Instance

variable "most_recent_ami" {
  type        = bool
  description = "Check for the most recent AMI distribution in a region"
  default     = true
}

variable "ami_owner" {
  type        = string
  description = "Owner for the AMI"
  default     = "amazon"
}

variable "birthday_ami_family" {
  type        = string
  description = "Family for which the AMI belongs to (OS family)"
  default     = "amzn2-ami-hvm-*-x86_64-ebs"
}

variable "birthday_ec2_role_name" {
  type        = string
  description = "Role name to attach to the instance"
  default     = "ec2-role-birthday-app"
}

variable "birthday_ec2_profile_name" {
  type        = string
  description = "Instance profile to attach for the EC2 intance"
  default     = "ec2-profile-birthday-app"
}

variable "birthday_ec2_policy" {
  type        = string
  description = "Policy with permissions that a role can use"
  default     = "ec2-policy-birthday-app"
}

variable "instance_type" {
  type        = string
  description = "Instance type to be provisioned as"
  default     = "t3.medium"
}

variable "root_volume_size" {
  type        = number
  description = "Size of the root volume to provision the intance with"
  default     = 32
}

variable "docker" {
  type        = string
  description = "User data to be run in when spinning up an instance"
  default     = "templates/docker-build-compose.sh"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Give a public IP address on the instance"
  default     = true
}

variable "public_key" {
  type        = string
  description = "Public key to be used in authorized_keys in order to connect to the instance over SSH"
  default     = "keys/app_id_rsa.pub"
}

variable "key_name" {
  type        = string
  description = "Give the SSH key pair a names"
  default     = "birthday_app_key_pair"
}
