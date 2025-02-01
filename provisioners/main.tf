resource "aws_security_group" "provision" {
  name = "provision"
  # ... other configuration ...

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

   tags = {
    Name = "allow_tls"
  }
}


resource "aws_instance" "newinstance" {
  ami           = "ami-09c813fb71547fc4f"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
  security_groups = [aws_security_group.provision.name]

  tags = {
    Name = "server"
  }

    provisioner "local-exec" {
    command = "echo ${self.private_ip} > private.txt"
  }

    connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
     "sudo dnf install nginx -y",
     "sudo systemctl start nginx",

    ]
  }

   provisioner "remote-exec" {
    when = destroy
    inline = [
      "sudo systemctl stop nginx",
    ]
  }
}

