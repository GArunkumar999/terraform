data "aws_ssm_parameter" "vpc_id" {
  name = "/expense/dev/vpc_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/expense/dev/public_subnet_ids"
}

data "aws_ssm_parameter" "openvpn_sg_id" {
  name = "/expense/dev/openvpn_sg_id"
}

locals {
  public_subnet_ids = data.aws_ssm_parameter.public_subnet_ids.value
}
locals {
  pub_id = split(",",local.public_subnet_ids)
}

data "aws_ssm_parameter" "back_alb_sg" {
  name = "/expense/dev/back-alb_sg_id"
}

data "aws_ami" "openvpn_ami_id" {

  most_recent      = true
  owners           = ["679593333241"]

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image-fe8020db-5343-4c43-9e65-5ed4a825c931"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# output "openvpn_ami_id" {
#   value = data.aws_ami.openvpn_ami_id.image_id
  
# }


