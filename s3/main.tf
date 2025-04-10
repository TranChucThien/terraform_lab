provider "aws" {
  region = "us-east-2"

}





resource "aws_s3_bucket" "chucthien_backend" {
  bucket = "chucthien-backend-s3"

  tags = {
    Name        = "chucthien-backend"
    Environment = "dev"
  }



}

resource "aws_s3_bucket_versioning" "chucthien_backend_versioning" {
  bucket = "chucthien-backend-s3"
  versioning_configuration {
    status = "Enabled"
  }

}







