# Declare the security group
resource "aws_security_group" "terraform" {
  name        = "terraform"
  description = "Allow ssh"
  tags = {
    Name = "TERRAFORM"
  }

  dynamic "ingress" {
    for_each = var.ingress_var
    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }

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
  ami             = "ami-0ac4dfaf1c5c0cce9" # Replace with a valid AMI ID
  instance_type   = "t2.micro"
  key_name        = "arun"
  security_groups = [aws_security_group.terraform.name]

  tags = {
    Name = "TERRAFORM"
  }
}

