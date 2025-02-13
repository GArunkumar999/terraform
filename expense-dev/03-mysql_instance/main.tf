resource "aws_instance" "mysql" {
  ami           = "ami-0ac4dfaf1c5c0cce9"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.mysql-sg-id.value]
  subnet_id = local.subnet_ids[0]
  
  tags = {
    Name = "expense-mysql"
  }
}

