resource "aws_ssm_parameter" "mysql-sg" {
  name  = "/${var.project}/${var.environment}/mysql_sg_id"
  type  = "String"
  value = module.mysql-sg.sg_id
}
resource "aws_ssm_parameter" "backend-sg" {
  name  = "/${var.project}/${var.environment}/backend_sg_id"
  type  = "String"
  value = module.backend-sg.sg_id
}
resource "aws_ssm_parameter" "frontend-sg" {
  name  = "/${var.project}/${var.environment}/frontend_sg_id"
  type  = "String"
  value = module.frontend-sg.sg_id
}

resource "aws_ssm_parameter" "back-alb-sg" {
  name  = "/${var.project}/${var.environment}/back-alb_sg_id"
  type  = "String"
  value = module.back-alb-sg.sg_id
}

resource "aws_ssm_parameter" "web-alb-sg" {
  name  = "/${var.project}/${var.environment}/web-alb_sg_id"
  type  = "String"
  value = module.web-alb-sg.sg_id
}
resource "aws_ssm_parameter" "bastionsg" {
  name  = "/${var.project}/${var.environment}/bastion_sg_id"
  type  = "String"
  value = module.bastion-sg.sg_id
}

resource "aws_ssm_parameter" "openvpn_sg" {
  name  = "/${var.project}/${var.environment}/openvpn_sg_id"
  type  = "String"
  value = module.openvpn-sg.sg_id
}





