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
  default = ["hillary", "ofweneke", "linda"]
}

resource "aws_iam_user" "my_iam_users" {
  count         = length(var.names)
  name          = var.names[count.index]
  force_destroy = true
}
