resource "aws_instance" "my_instance" {
  ami           = "ami-0a7cf821b91bcccbc"
  count = 1
  instance_type = "t2.micro"
  key_name      = "RJAWS"

  tags = {
    Name = "First_Terraform_resource_creation"
  }
}



resource "aws_s3_bucket" "s3_backend" {
  bucket = "s3-backend-terraform-project-59"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_backend_sse" {
  bucket = aws_s3_bucket.s3_backend.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "s3_backend_sse_versioning" {
  bucket = aws_s3_bucket.s3_backend.id
  versioning_configuration {
    status = "Enabled"
  }
  depends_on = [ aws_s3_bucket_server_side_encryption_configuration.s3_backend_sse ]
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "s3-backend-locking-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

}