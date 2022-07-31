resource "null_resource" "describe-security-group-rules" {
  provisioner "local-exec" {
    command = "aws ec2 describe-security-group-rules --filter Name=group-id,Values=$GROUP_IDS >> security-groups-rules.json"
    environment = {GROUP_IDS = join(",", data.aws_security_groups.security-groups.ids)}
  }
  depends_on = [
    data.aws_security_groups.security-groups
  ]
} 