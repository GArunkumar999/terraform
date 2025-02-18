resource "aws_ssm_parameter" "frontend_ami_id"{
  name  = "/${var.project}/${var.environment}/frontend_ami_id"
  type  = "String"
  value = aws_ami_from_instance.frontend_ami.id
}