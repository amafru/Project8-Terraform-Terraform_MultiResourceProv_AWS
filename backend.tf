terraform {
  backend "s3" {
    bucket = "temp-terraform-state237"
    key    = "terraform/project8_backend"
    region = "us-east-1" //Note: Variables may not be used here. e.g. like var.REGION
  }
}