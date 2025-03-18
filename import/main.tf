resource "aws_instance" "import" {
  instance_type = "t2.micro"
  ami           = "ami-053a45fff0a704a47"

  tags = {
    Name = "testing"
  }
}