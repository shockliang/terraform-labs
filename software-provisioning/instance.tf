resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("${var.PATH_TO_PUBLIC_KEY}")
}

resource "aws_instance" "software-provisioning" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.software-provisioning.private_ip} >> private_ips.txt"
  }
  connection {
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file("${var.PATH_TO_PRIVATE_KEY}")
    host        = coalesce(self.public_ip, self.private_ip)
  }
}

output "ip" {
  value = aws_instance.software-provisioning.public_ip
}
