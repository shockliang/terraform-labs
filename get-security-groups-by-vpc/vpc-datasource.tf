data "aws_vpc" "exist" {
  filter {
    name   = "tag-value"
    values = ["${var.vpc_name}"]
  }
  filter {
    name   = "tag-key"
    values = ["Name"]
  }
}

output "exist-vpc-id" {
  value = data.aws_vpc.exist.id
}

