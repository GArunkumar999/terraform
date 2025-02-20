# Declare the security group
resource "aws_security_group" "tf" {
  name        = "tf"
  description = "Allow ssh"
  tags = {
    Name = "ALLOW-ALL"
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
  ami             = var.ami_id # Replace with a valid AMI ID
  instance_type   = var.inst_type
  key_name        = var.key_name
  security_groups = [aws_security_group.tf.name]

  tags = {
    Name = "TERRAFORM"
  }
}




