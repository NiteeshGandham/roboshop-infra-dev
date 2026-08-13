resource "aws_instance" "catalogue" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.private_subnet_id
  vpc_security_group_ids = [local.catalogue_sg_id]

  tags =merge(
    local.tags,
     {
        Name = "${var.project}-${var.environment}-catalogue"
     }
     
  )
}

resource "terraform_data" "bootstrap" {
   triggers_replace  = [aws_instance.catalogue.id]

    connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.catalogue.private_ip
  }

   provisioner "file" {
    source      = "bootstrap.sh" #local file path
    destination = "/tmp/bootstrap.sh" #destination path in remote
  }
   provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh catalogue" 
    ]
  }
}

resource "aws_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on = [aws_instance.catalogue]
}

resource "aws_ami_from_instance" "catalogue" {
  name = "${var.project}-${var.environment}-catalogue"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [aws_instance_state.catalogue]
}