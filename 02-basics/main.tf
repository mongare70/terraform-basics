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

variable "iam_user_name_prefix" {
  type    = string #any, number, bool, list, map, set, object
  default = "my_iam_user"
}

resource "aws_iam_user" "my_iam_users" {
  count         = 3
  name          = "${var.iam_user_name_prefix}_${count.index}"
  force_destroy = true
}
