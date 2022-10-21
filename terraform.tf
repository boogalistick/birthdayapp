terraform {
  required_version = "~> 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.60"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
  # assume_role {
  #   role_arn = var.account_role_arn
  # }
}