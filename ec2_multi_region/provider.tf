terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}

provider "aws" {
  # Configuration options
  alias  = "us-east-1"
  region = "us-east-1"

}

provider "aws" {
  # Configuration options
  alias  = "us-west-1"
  region = "us-west-1"

}

provider "aws" {
  # Configuration options
  alias  = "ap-south-1"
  region = "ap-south-1"

}