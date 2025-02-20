resource "aws_instance" "expense" {
  count         = 3
  ami           = "ami-0c614dee691cbbf37"
  instance_type = "t2.micro"

  tags = {
    Name = var.names[count.index]
  }

}