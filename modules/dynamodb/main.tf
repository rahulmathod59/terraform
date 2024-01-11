resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "s3-backend-locking-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

}