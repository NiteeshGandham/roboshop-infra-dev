resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.database_subnet_id
  vpc_security_group_ids = [local.mongodb_sg_id]

  tags =merge(
    local.tags,
     {
        Name = "${var.project}-${var.project}-mongodb"
     }
     
  )
}

resource "terraform_data" "bootstrap" {
   triggers_replace  = [aws_instance.mongodb.id]

    connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.mongodb.private_ip
  }

   provisioner "file" {
    source      = "bootstrap.sh" #local file path
    destination = "/tmp/bootstrap.sh" #destination path in remote
  }
   provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh"
    ]
  }
}
