resource "aws_ssm_parameter" "expense-vpc-id" {
  name  = "/${var.project}/${var.environment}/sg_id"
  type  = "String"
  value = module.sg.sg_id
}