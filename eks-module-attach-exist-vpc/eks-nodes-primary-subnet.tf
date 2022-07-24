resource "aws_subnet" "eks-node-primary-subnet" {
  vpc_id                  = data.aws_vpc.exist.id
  cidr_block              = "172.39.16.0/20"
  availability_zone       = "${var.AWS_REGION}a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "${local.name}-node-primary-subnet"
  }
  depends_on = [
    data.aws_vpc.exist
  ]
}