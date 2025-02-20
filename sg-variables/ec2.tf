resource "aws_instance" "server" {
  ami           = "ami-0ac4dfaf1c5c0cce9" # Replace with a valid AMI ID
  instance_type = "t2.micro"
  #only refer by name if you refer by security_groups
  security_groups = [aws_security_group.new-sg.name]
  #only refer by id if you refer by vpc_security_group_ids
  vpc_security_group_ids = [aws_security_group.new-sg.id]
  tags = {
    Name = "server1"
  }
}

resource "aws_security_group" "new-sg" {
  name        = "new-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"


  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

output "sg-info" {
  value = aws_security_group.new-sg.name
}

output "sg-info" {
  value = aws_security_group.new-sg.id
}