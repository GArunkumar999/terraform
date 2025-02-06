module "expense-vpc" {
  source = "../vpc-main-module"
  cidr_block = var.cidr_range
  cidr_public =  var.cidr_list_public
 cidr_private = var.cidr_list_private
 cidr_database = var.cidr_list_database
  is_vpc_peering_required = true
}
