
resource "aws_instance" "newinstance" {
  count         = length(var.names)
  ami           = "ami-0ac4dfaf1c5c0cce9" # Replace with a valid AMI ID
  instance_type = "t2.micro"
  key_name      = "arun"

  tags = {
    Name = var.names[count.index] # Tag each instance with the name from var.names
  }
}




