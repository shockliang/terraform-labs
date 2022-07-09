resource "aws_instance" "instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.INSTANCE_TYPE

  # the VPC subnet
  subnet_id = element(var.PUBLIC_SUBNETS, 0)

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

  tags = {
    Name         = "instance-${var.ENV}"
    Environmnent = var.ENV
  }
}