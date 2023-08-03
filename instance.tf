resource "aws_key_pair" "project8-key" {
  key_name   = "project8-terraform-key"
  public_key = file(var.PUB_KEY)
}

resource "aws_instance" "project8-webserver-instance" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.project8-pub-sub1.id
  key_name               = aws_key_pair.project8-key.key_name
  vpc_security_group_ids = [aws_security_group.project8-stack-sg.id]
  tags = {
    Name    = "project8-web-server"
    Project = "Project8"
  }

  # Now we push our web.sh file to our instance
  # Note how 'provisioner' and 'connection' blocks are WITHIN the 'aws_instance block!

  #First we push our web.sh script to a dir on the ec2 instance
  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  #Then we make executable and execute the script using remote-exec Provisioner
  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  #Here we spec. the connection and user details to use for provisioning
  connection {
    user        = var.USER
    private_key = file(var.PRIV_KEY)
    host        = self.public_ip
  }
}

//Create EBS volume
resource "aws_ebs_volume" "project8-ebs-vol" {
  availability_zone = var.ZONE1
  size              = 3
  tags = {
    Name = "project8-ebs-vol"
  }
}

//Attach the EBS volume
resource "aws_volume_attachment" "project8-ebs-vol-attach" {
  device_name = "/dev/xvdh" //Note the 'xvdh' value is not random!
  volume_id   = aws_ebs_volume.project8-ebs-vol.id
  instance_id = aws_instance.project8-webserver-instance.id
}


output "PublicIP" {
  value = aws_instance.project8-webserver-instance.public_ip
}
