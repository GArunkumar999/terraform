data "aws_ssm_parameter" "vpc_id" {
  name = "/expense/dev/vpc_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/expense/dev/public_subnet_ids"
}

data "aws_ssm_parameter" "bastion_sg_id" {
  name = "/expense/dev/bastion_sg_id"
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