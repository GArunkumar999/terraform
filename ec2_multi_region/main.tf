resource "aws_instance" "server1" {
  ami           = var.ami_id1 # Replace with a valid AMI ID
  instance_type = var.instance_type
  provider      = aws.us-east-1

  tags = {
    Name = "server"
  }
}

resource "aws_instance" "server2" {
  ami           = var.ami_id2 # Replace with a valid AMI ID
  instance_type = var.instance_type
  provider      = aws.us-west-1 # no double quotes arround this aws.us-west-1

  tags = {
    Name = "server"
  }
}

resource "aws_instance" "server3" {
  ami           = var.ami_id3 # Replace with a valid AMI ID
  instance_type = var.instance_type
  provider      = aws.ap-south-1

  tags = {
    Name = "server"
  }
}