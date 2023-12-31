terraform {
  backend "s3" {
    bucket = "dev-applications-backend-state-hillary-abc"
    # key            = "07-backend-state-users-dev"
    key            = "dev/07-backend-state/users/backend-state"
    region         = "us-east-1"
    dynamodb_table = "dev_application_locks"
    encrypt        = true
  }

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

resource "aws_iam_user" "my_iam_user" {
  name          = "my_iam_user_abc"
  force_destroy = true
}
