module "vpc" {
  source = "../vpc-module"
  common_tags = var.tags
  cidr_block = var.cidr
  purpose = var.usecase
}