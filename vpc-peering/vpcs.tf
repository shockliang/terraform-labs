module "vpc-one" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-one"
  cidr = "10.0.0.0/16"
  
  azs             = ["${var.AWS_REGION}a",]
  public_subnets  = ["10.0.0.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}

module "vpc-two" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-two"
  cidr = "10.1.0.0/16"

  azs             = ["${var.AWS_REGION}a",]
  public_subnets  = ["10.1.0.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}