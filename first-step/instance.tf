provider "aws" {
  access_key = "my_key"
  secret_key = "my_secret_key"
  region = "us-east-1"
}

resource "aws_instance" "terrafrom-first-step" {
    ami = "ami-0f65ab0fd913bc7be"
    instance_type = "t2.micro"
}