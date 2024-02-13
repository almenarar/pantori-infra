terraform {
  backend "s3" {
    bucket = "pantori-app"
    key    = "tfstate"
    region = "us-east-1"
  }
}
