module "sg" {
  source       = "../sg-module"
  environment  = var.environment
  app          = var.app
  description  = var.description
  project_name = var.project
  vpc_id       = data.aws_ssm_parameter.vpc_id.value




}