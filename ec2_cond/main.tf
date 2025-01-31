resource "aws_instance" "newinstance" {
  ami           = "ami-0ac4dfaf1c5c0cce9"  # Replace with a valid AMI ID
  instance_type = var.environment == "prod" ? "t2.micro" : "t2.medium"
  key_name = "arun"

  tags = {
    Name = "TERRAFORM"
  }
}