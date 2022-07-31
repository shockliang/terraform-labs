output "vpc-id" {
  description = "Vpc id"
  value = data.aws_vpc.exist.id
}

output "security-groups-ids" {
  value = data.aws_security_groups.security-groups.ids
}

output "security-group-description" {
  value = data.aws_security_group.security-group.arn
}