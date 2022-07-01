# group
resource "aws_iam_group" "tf-administrators" {
  name = "tf-administrators"
}
resource "aws_iam_policy_attachment" "tf-administrators-attach" {
  name = "tf-administrators-attach"
  groups = [aws_iam_group.tf-administrators.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# user
resource "aws_iam_user" "admin1" {
  name = "admin1"
}
resource "aws_iam_user" "admin2" {
  name = "admin2"
}
resource "aws_iam_group_membership" "tf-administrators-users" {
  name = "tf-administrators-users"
  users = [ 
    aws_iam_user.admin1.name,
    aws_iam_user.admin2.name
  ]
  group = aws_iam_group.tf-administrators.name
}

