resource "aws_dynamodb_table" "example_table" {
  name           = "TF-state-table" # DynamoDB table name
  hash_key       = "LockID"         # Partition key (Primary key)
  read_capacity  = 2
  write_capacity = 2
  attribute {
    name = "LockID" # Partition key attribute name
    type = "S"      # Data type (S = String)
  }
}