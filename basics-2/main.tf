terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "my_iam_users" {
  count         = 3
  name          = "my_iam_user_${count.index}"
  force_destroy = true
}
