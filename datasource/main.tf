# Declare the security group
resource "aws_security_group" "terraform" {
  name        = "terraform"
  description = "Allow ssh"
  tags = {
    Name = "TERRAFORM"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # You can add more rules as needed
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "newinstance" {
  ami = data.aws_ami.example.id

  instance_type   = "t2.micro"
  key_name        = "arun"
  security_groups = [aws_security_group.terraform.name]

  tags = {
    Name = "TERRAFORM"
  }
}

