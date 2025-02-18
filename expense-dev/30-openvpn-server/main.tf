
#AWS Instance
resource "aws_instance" "openvpn" {
  ami           = data.aws_ami.openvpn_ami_id.image_id # Replace with a valid AMI ID
  instance_type = "t2.micro"
  user_data = file("userdata.sh")
  associate_public_ip_address = true
  vpc_security_group_ids = [data.aws_ssm_parameter.openvpn_sg_id.value]
   subnet_id     = local.pub_id[0]

 
  tags = {
    Name = "openvpn"
  }
}

