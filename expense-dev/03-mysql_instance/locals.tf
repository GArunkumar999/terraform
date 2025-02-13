locals {
  subnet_ids = split(",", data.aws_ssm_parameter.mysql_sub_id.value)
  
}