variable "AWS_REGION" {
  default = "us-east-1"
}

variable "ports" {
  type    = list(number)
  default = [22, 443, 80]
}
