#change version to desired version, leave as is for latest aws provider

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "playgroundarea"
    workspaces {
      name = "aws_docker_stack"
   }
  }
}

provider "aws" {
  region = "us-east-2"
  #version = "~> 2.56"
  shared_credentials_file = "/root/aws/creds"
}

