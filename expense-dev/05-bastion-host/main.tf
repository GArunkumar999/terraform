
# AWS Instance
resource "aws_instance" "bastion" {
  ami           = "ami-0c50b6f7dc3701ddd"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
  key_name = "arun1"
  associate_public_ip_address = true
  vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
   subnet_id     = local.pub_id[0]

 
  tags = {
    Name = "bastion"
  }
}

