terraform {
  backend "s3" {
    bucket = "terra-bucket-30"
    key    = "tfstate-file"
    region = "eu-west-2"

  }
}