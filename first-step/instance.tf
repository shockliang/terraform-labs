provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region = "${var.AWS_REGION}"
}

resource "aws_instance" "terrafrom-first-step" {
    ami = "ami-0f65ab0fd913bc7be"
    instance_type = "t2.micro"
}