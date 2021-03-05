provider "aws" {
  region = "ap-northeast-2" # Please use the default region ID
}

# S3 bucket for backend
resource "aws_s3_bucket" "tfstate" {
  bucket = "ljw-terra-backend" #Global Unique

  versioning {
    enabled = true # Prevent from deleting tfstate file
  }
}

# DynamoDB for terraform state lock
######### DO NOT TOUCH #############
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-lock"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
######### DO NOT TOUCH #############
