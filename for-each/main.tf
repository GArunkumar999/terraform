resource "aws_instance" "newinstance" {
  for_each = var.instance
  ami           = "ami-0ac4dfaf1c5c0cce9"  # Replace with a valid AMI ID
  instance_type = each.value
  key_name = "arun"

  tags = {
    Name = each.key
  }
}