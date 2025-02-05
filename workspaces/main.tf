resource "aws_instance" "expense" {
  count = length(var.instances)
  ami             = "ami-0ac4dfaf1c5c0cce9" # Replace with a valid AMI ID
  instance_type   = var.instance_type
  security_groups = [aws_security_group.terraform.name]

  tags = {
    Name = "${var.project}-${var.instances[count.index]}-${terraform.workspace}"
  }
}



# Declare the security group
resource "aws_security_group" "terraform" {
  name        = "${var.project}-${terraform.workspace}-SG"
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



