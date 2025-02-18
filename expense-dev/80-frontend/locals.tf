locals {
  public_subnet_ids = data.aws_ssm_parameter.public_subnet_id.value
}
locals {
  pub_id = split(",",local.public_subnet_ids)
}