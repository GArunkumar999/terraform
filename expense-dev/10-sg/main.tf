module "mysql-sg" {
  source       = "github.com/GArunkumar999/terraform.git/sg-module?ref=main"
  project_name = "expense"
  environment  = "dev"
  description  = "security group for mysql"
  app          = "mysql"
  vpc_id       = data.aws_ssm_parameter.vpc_id.value


}
module "backend-sg" {
  source       = "github.com/GArunkumar999/terraform.git/sg-module?ref=main"
  project_name = "expense"
  environment  = "dev"
  description  = "security group for backend"
  app          = "backend"
  vpc_id       = data.aws_ssm_parameter.vpc_id.value

}
module "frontend-sg" {
  source       = "github.com/GArunkumar999/terraform.git/sg-module?ref=main"
  project_name = "expense"
  environment  = "dev"
  description  = "security group for frontend"
  app          = "frontend"
  vpc_id       = data.aws_ssm_parameter.vpc_id.value

}

module "back-alb-sg" {
  source       = "github.com/GArunkumar999/terraform.git/sg-module?ref=main"
  project_name = "expense"
  environment  = "dev"
  description  = "security group for backend alb"
  app          = "back-alb"
  vpc_id       = data.aws_ssm_parameter.vpc_id.value



}


module "web-alb-sg" {
  source       = "github.com/GArunkumar999/terraform.git/sg-module?ref=main"
  project_name = "expense"
  environment  = "dev"
  description  = "security group for web alb"
  app          = "web-alb"
  vpc_id       = data.aws_ssm_parameter.vpc_id.value



}

module "bastion-sg" {
  source       = "github.com/GArunkumar999/terraform.git/sg-module?ref=main"
  project_name = "expense"
  environment  = "dev"
  description  = "security group for bastion"
  app          = "bastion"
  vpc_id       = data.aws_ssm_parameter.vpc_id.value

}

module "openvpn-sg" {
  source       = "github.com/GArunkumar999/terraform.git/sg-module?ref=main"
  project_name = "expense"
  environment  = "dev"
  description  = "security group for openvpn"
  app          = "openvpn"
  vpc_id       = data.aws_ssm_parameter.vpc_id.value

}


#backend alb allowing http traffic from bastion
resource "aws_security_group_rule" "back_alb_bastion" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.bastion-sg.sg_id
  security_group_id        = module.back-alb-sg.sg_id
}
# frontend allowing traffic from web alb
resource "aws_security_group_rule" "frontend_web_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.web-alb-sg.sg_id
  security_group_id = module.frontend-sg.sg_id
}

# bastion server should be accessed by anyone from anywhere
resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion-sg.sg_id
}

resource "aws_security_group_rule" "frontend_sg_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.frontend-sg.sg_id
}

# web alb should be accessed by anyone from anywhere from https
resource "aws_security_group_rule" "web_alb_public" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.web-alb-sg.sg_id
}


#vpn sg allowing port 22 for ssh
resource "aws_security_group_rule" "vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.openvpn-sg.sg_id
}


#vpn sg allowing https from anyone from anywhere
resource "aws_security_group_rule" "vpn_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.openvpn-sg.sg_id
}
#connect to vpn by enabling port 1194
resource "aws_security_group_rule" "vpn_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.openvpn-sg.sg_id
}

#connect to vpn by enabling port 943
resource "aws_security_group_rule" "vpn_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.openvpn-sg.sg_id
}

#backend alb allowing http traffic from vpn
resource "aws_security_group_rule" "back_alb_openvpn" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.openvpn-sg.sg_id
  security_group_id        = module.back-alb-sg.sg_id
}

#mysql allowing 3306 traffic from bastion
resource "aws_security_group_rule" "app_mysql_bastion" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.bastion-sg.sg_id
  security_group_id        = module.mysql-sg.sg_id
}

#mysql allowing 3306 traffic from vpn
resource "aws_security_group_rule" "app_mysql_vpn" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.openvpn-sg.sg_id
  security_group_id        = module.mysql-sg.sg_id
}

#backend allowing ssh traffic from vpn
resource "aws_security_group_rule" "backend_vpn_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.openvpn-sg.sg_id
  security_group_id        = module.backend-sg.sg_id
}

#mysql allowing 3306 traffic from backend
resource "aws_security_group_rule" "mysql_from_backend" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.backend-sg.sg_id
  security_group_id        = module.mysql-sg.sg_id
}

#backend allowing 8080 traffic from vpn
resource "aws_security_group_rule" "backend_vpn" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.openvpn-sg.sg_id
  security_group_id        = module.backend-sg.sg_id
}

#backend allowing 8080 traffic from backend alb
resource "aws_security_group_rule" "backend_alb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.back-alb-sg.sg_id
  security_group_id        = module.backend-sg.sg_id
}

#backend alb allowing 8080 traffic from vpn 
resource "aws_security_group_rule" "back_alb_openvpn_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.openvpn-sg.sg_id
  security_group_id        = module.back-alb-sg.sg_id
}

#backend alb allowing 8080 from frontend server(nginx.conf)
resource "aws_security_group_rule" "back_alb_frontend_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.frontend-sg.sg_id
  security_group_id        = module.back-alb-sg.sg_id
}

