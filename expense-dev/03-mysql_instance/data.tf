data "aws_ssm_parameter" "mysql-sg-id" {
    name = "/expense/dev/mysql_sg_id"
  
}

# output "mysql_sg_id" {
#   value = data.aws_ssm_parameter.mysql-sg-id.value
# }

data "aws_ssm_parameter" "vpc_id" {
  name = "/expense/dev/vpc_id"
}

# output "vpc-id" {

#   value = data.aws_ssm_parameter.vpc_id.value
# }

data "aws_ssm_parameter" "mysql_sub_id"{
    name = "/expense/dev/database_subnet_ids"
  
}

# output "ids" {
#   value = data.aws_ssm_parameter.mysql_sub_id.value
  
# }