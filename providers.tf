terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67.0"
    }
  }

  backend "s3" {
    encrypt              = true
    region               = "sa-east-1"
    bucket               = "galp-terraform-state"
    key                  = "terraform.tfstate"
    dynamodb_table       = "galp-terraform-state-lock"
  }
}

provider "aws" {
  region  = var.region
}