resource "aws_vpc_peering_connection" "one-and-two-peering" {
  peer_vpc_id = module.vpc-one.vpc_id
  vpc_id = module.vpc-two.vpc_id
  peer_region = "${var.AWS_REGION}"

  tags = {
    Name = "VPC Peering between ${ module.vpc-one.name} and ${ module.vpc-two.name}"
  }
}