# these resources are added to provide the vpc_id and subnets to the consul module

# default vpc
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# default subnets
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_subnet
# If no default subnet exists, Terraform creates a new default subnet. By default,
# terraform destroy does not delete the default subnet but does remove the resource from Terraform state. 
# Set the `force_destroy` argument to true to delete the default subnet.

resource "aws_default_subnet" "default_az1" {
  availability_zone = "${var.AWS_REGION}a"

  tags = {
    Name = "Default subnet for ${var.AWS_REGION}a"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = "${var.AWS_REGION}b"

  tags = {
    Name = "Default subnet for ${var.AWS_REGION}b"
  }
}

resource "aws_default_subnet" "default_az3" {
  availability_zone = "${var.AWS_REGION}c"

  tags = {
    Name = "Default subnet for ${var.AWS_REGION}c"
  }
}