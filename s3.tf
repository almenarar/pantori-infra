resource "aws_s3_bucket" "bucket" {
  bucket = "pantori-app"

  tags = {
    Name        = "pantori-app"
    Owner       = "Pantori"
    Environment = "Production"
  }
}