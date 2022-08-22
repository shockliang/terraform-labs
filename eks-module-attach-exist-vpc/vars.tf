variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0f65ab0fd913bc7be"
    us-west-1 = "ami-08daca4640726cc73"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

# locals {
#   cluster_name = "lab-eks-${random_string.suffix.result}"
# }

locals {
  # name   = "ex-${replace(basename(path.cwd), "_", "-")}"
  name   = "testing-eks"
  region = "us-east-1"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-eks"
    GithubOrg  = "terraform-aws-modules"
  }
}

variable "vpc_name" {
  default = "vpc-testing"
}

variable "users" {
  type = list(object({
    userarn = string
    username = string
    groups = list(string)
  }))
  default = []
}

variable "istio_version" {
  default = "1.14.1"
}

variable "istio_namespace" {
  default = "istio-system"
}

variable "ebs_csi_controller_role_name" {
  default = "testing-eks-ebs-csi-controller"
}
