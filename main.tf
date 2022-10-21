module "network" {
  source                       = "./modules/vpc"
  aws_region                   = var.aws_region
  vpc_cidr_block               = var.vpc_cidr_block
  enable_dns_hostnames         = var.enable_dns_hostnames
  enable_dns_support           = var.enable_dns_support
  cidr_block_public            = var.cidr_block_public
  birthday_security_group_name = var.birthday_security_group_name
}

module "compute" {
  source                          = "./modules/instance"
  most_recent_ami                 = var.most_recent_ami
  ami_owner                       = var.ami_owner
  birthday_ami_family             = var.birthday_ami_family
  birthday_ec2_role_name          = var.birthday_ec2_role_name
  birthday_ec2_profile_name       = var.birthday_ec2_profile_name
  birthday_ec2_policy             = var.birthday_ec2_policy
  instance_type                   = var.instance_type
  root_volume_size                = var.root_volume_size
  docker                          = var.docker
  birthday_public_subnet_id       = module.network.subnet_id
  birthday_vpc_security_group_ids = module.network.subnet_security_group
  associate_public_ip_address     = var.associate_public_ip_address
  key_name                        = var.key_name
  public_key                      = var.public_key
}