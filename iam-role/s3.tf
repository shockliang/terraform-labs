
resource "aws_s3_bucket" "b" {
  bucket = "shock-tf-lab-0836449"

  tags = {
    Name = "shock-tf-lab-0836449"
  }
}