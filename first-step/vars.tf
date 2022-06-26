variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "us-east-1"
}

variable "AMIS" {
  type = map
  default = {
      us-east-1 = "ami-0f65ab0fd913bc7be"
      us-west-1 = "ami-08daca4640726cc73"
  }
}