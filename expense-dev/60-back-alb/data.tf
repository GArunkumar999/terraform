data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

# output "vpc-id" {
#   value = data.aws_ssm_parameter.vpc_id.value
# }

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project}/${var.environment}/private_subnet_ids"
}

data "aws_ssm_parameter" "back-alb-id" {
  name = "/${var.project}/${var.environment}/back-alb_sg_id"

}

data "aws_ssm_parameter" "backend_ami_id" {
  name = "/${var.project}/${var.environment}/backend_ami_id"


}

data "aws_ssm_parameter" "backend_sg_id" {
  name ="/${var.project}/${var.environment}/backend_sg_id"

}

data "aws_ssm_parameter" "private_subnet_id" {
   name = "/${var.project}/${var.environment}/private_subnet_ids"
}
