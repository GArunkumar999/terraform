
resource "aws_instance" "newinstance" {
  count         = 3
  ami           = var.ami_id # Replace with a valid AMI ID
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = var.tag_name[count.index]
  }
}