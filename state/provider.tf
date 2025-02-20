terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }

  backend "s3" {
    bucket         = "my-tf-state-buckets5"
    key            = "file.state"
    region         = "us-east-1"
    dynamodb_table = "tf-state-table"
  }
}


provider "aws" {
  # Configuration options
  region = "us-east-1"

}