provider "aws" {
  region = "us-east-1"
}

# Retrieve the list of AZs in the current AWS region
data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

# Locals
locals {
  team        = "devops"
  application = "profile"
  server_name = "ec2_${var.environment}-api-${var.variables_sub_az}"
}

resource "aws_s3_bucket" "my_s3_bucket" {
  # bucket = "unique-tf-test-bucket-${random_id.randomness.hex}"
  bucket = "unique-tf-test-bucket-${random_id.randomness.hex}"

  tags = {
    Name    = "My Test Bucket"
    Purpose = "Intro"
    Owner   = local.team
    Name    = local.server_name
    App     = local.application

  }

}

resource "aws_s3_bucket_acl" "my_s3_bucket_acl" {
  bucket = "aws_s3_bucket.my_s3_bucket"
  acl    = "private"
}

resource "random_id" "randomness" {
  byte_length = 16
}

resource "tls_private_key" "generated" {
  algorithm = "RSA"
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.generated.private_key_pem
  filename = "MyAWSKey.pem"
}