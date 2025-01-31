resource "aws_dynamodb_table" "example_table" {
  name           = "tf-state-table"  # DynamoDB table name
   hash_key       = "LockID"                # Partition key (Primary key)
  read_capacity  = 5                   # Read capacity units
  write_capacity = 5                   # Write capacity units

  attribute {
    name = "LockID"                      # Partition key attribute name
    type = "S"                        # Data type (S = String)
  }
}