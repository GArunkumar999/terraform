resource "aws_ssm_parameter" "backend_ami_id"{
  name  = "/${var.project}/${var.environment}/backend_ami_id"
  type  = "String"
  value = aws_ami_from_instance.backend_ami.id
}