resource "aws_instance" "terraform" {
  ami           = "ami-0c614dee691cbbf37"
  instance_type = var.inst_type

  tags = {
    Name = "server"
  }
}