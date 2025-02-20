
# AWS Instance
resource "aws_instance" "newinstance" {
  ami                    = "ami-0ac4dfaf1c5c0cce9" # Replace with a valid AMI ID
  instance_type          = "t2.micro"
  vpc_security_group_ids = [var.sg_id]

  tags = {
    Name = "TERRAFORM"
  }
}

# Output the security group ID
# output "sg_id" {
#   value = aws_security_group.terraform.id
# }
