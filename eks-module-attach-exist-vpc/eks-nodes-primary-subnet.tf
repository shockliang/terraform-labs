resource "aws_subnet" "eks-node-primary-subnet" {
  vpc_id                  = data.aws_vpc.exist.id
  cidr_block              = "172.39.16.0/20"
  availability_zone       = "${var.AWS_REGION}a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                = "${local.name}-node-primary-subnet"
    "kubernetes.io/cluster/${local.name}" = "owned"
    # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.2/deploy/subnet_discovery/
    # "kubernetes.io/role/internal-elb" = 1
    "kubernetes.io/role/elb" = 1
  }
  depends_on = [
    data.aws_vpc.exist
  ]
}