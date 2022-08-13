terraform {
  backend "s3" {
    bucket = "terraform-state-0836449"
    key = "staging"
    region = "us-east-1"
    dynamodb_endpoint = "https://dynamodb.us-east-1.amazonaws.com"
    dynamodb_table = "terraform-backend"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  workspace = "staging"
  config = {
    bucket = "terraform-state-0836449"
    key = "staging"
    region = "us-east-1"
   }
}
