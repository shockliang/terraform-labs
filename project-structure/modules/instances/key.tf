resource "aws_key_pair" "mykeypair" {
  key_name   = "mykey-${var.ENV}"
  public_key = file("${path.root}/${var.PATH_TO_PUBLIC_KEY}")
}