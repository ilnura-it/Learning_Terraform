provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_s3_bucket" {
 # bucket = "unique-tf-test-bucket-${random_id.randomness.hex}"
  bucket = "unique-tf-test-bucket-${random_id.randomness.hex}"

  tags = {
    Name    = "My Test Bucket"
    Purpose = "Intro"
  }

}

resource "aws_s3_bucket_acl" "my_s3_bucket_acl" {
  bucket = "aws_s3_bucket.my_s3_bucket"
  acl    = "private"
}

resource "random_id" "randomness" {
   byte_length = 16
}