resource "aws_s3_bucket" "tf-bucket" {
  bucket = "tf-state--lock-buckets"

  tags = {
    Name        = "My bucket"
  }
}

