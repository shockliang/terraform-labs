terraform {
  backend "s3" {
    bucket = "terraform-state-0836449"
    key    = "terraform/backup"
  }
}
