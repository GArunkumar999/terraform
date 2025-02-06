resource "aws_ssm_parameter" "expense-vpc-id" {
  name  = "/${var.project}/${var.environment}/vpc_id"
  type  = "String"
  value = module.expense-vpc.vpc_id
}