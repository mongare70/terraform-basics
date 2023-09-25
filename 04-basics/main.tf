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

variable "names" {
  default = { justus : { country : "Kenya", department : "ABC" }, hillary : { country : "USA", department : "DEF" }, linda : { country : "Australia", department : "XYZ" } }
}

resource "aws_iam_user" "my_iam_users" {
  for_each      = var.names
  name          = each.key
  force_destroy = true
  tags = {
    # country each.value
    country : each.value.country
    department : each.value.department
  }
}
