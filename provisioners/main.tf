resource "aws_security_group" "provisioner" {
  name = "provision"
  # ... other configuration ...

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tlss"
  }
}


resource "aws_instance" "newinstance" {
  ami             = "ami-0c50b6f7dc3701ddd" # Replace with a valid AMI ID
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.provisioner.name]
  key_name        = "arun1"

  tags = {
    Name = "server"
  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} > private.txt"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("arun1")
    host        = self.public_ip
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

