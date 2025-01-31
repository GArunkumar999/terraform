resource "aws_s3_bucket" "tf-bucket" {
  bucket = "my-tf-state-buckets5"

  tags = {
    Name        = "My bucket"
  }
}

