terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }
  backend "s3" {
    bucket         = "tf-state--lock-buckets"
    key            = "file.state"
    region         = "us-east-1"
    dynamodb_table = "TF-state-table"
  }

}


provider "aws" {
  # Configuration options
  region = "us-east-1"

}