variable "cluster-name" {
  default = "terraform-eks-demo"
  type    = string
}

variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-1"
}
