terraform {
  backend "s3" {
    bucket         = "ekansh-poc1"
    key            = "terraform/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
  required_providers {
    aws = {}
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "aws-infra"
}

