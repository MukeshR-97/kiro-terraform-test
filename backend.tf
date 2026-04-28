terraform {
  backend "s3" {
    bucket = "wealwin-404587-ap-south-1"
    key    = "global/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
  }
}