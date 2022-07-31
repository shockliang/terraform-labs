data "aws_security_group" "security-group" {
  id = data.aws_security_groups.security-groups.ids[0]
}

