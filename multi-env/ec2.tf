resource "aws_instance" "expense" {
  count           = length(var.names)
  ami             = "ami-0ac4dfaf1c5c0cce9" # Replace with a valid AMI ID
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.multi-env.name]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project}-${var.environment}-${var.names[count.index]}" # expense-dev-mysql
    }
  )
}



# Declare the security group
resource "aws_security_group" "multi-env" {
  name        = "${var.project}-${var.environment}"
  description = "Allow ssh"
  tags = {
    Name = "MULTI-ENV"
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



