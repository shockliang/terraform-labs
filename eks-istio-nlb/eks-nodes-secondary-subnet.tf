resource "aws_subnet" "eks-node-secondary-subnet" {
  vpc_id                  = data.aws_vpc.exist.id
  cidr_block              = "172.39.64.0/24"
  availability_zone       = "${var.AWS_REGION}b"
  map_public_ip_on_launch = true
  tags = {
    "Name"                                = "${local.name}-node-secnodary-subnet-blue"
    "kubernetes.io/cluster/${local.name}" = "owned"
  }
  depends_on = [
    data.aws_vpc.exist
  ]
}