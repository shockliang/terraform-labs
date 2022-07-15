resource "aws_vpc_peering_connection" "one-and-two-peering" {
  peer_vpc_id = data.aws_vpc.exist.id
  vpc_id = module.vpc-one.vpc_id
  # peer_region = "${var.AWS_REGION}"
  auto_accept = true

  tags = {
    Name = "VPC Peering between ${ module.vpc-one.name} and ${var.vpc_name}"
  }

  depends_on = [
    data.aws_vpc.exist
  ]
}