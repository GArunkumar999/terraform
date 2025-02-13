# output "vpc_id" {
#     value = module.expense-vpc.vpc_ids
# }

# output "azs" {

#     value = module.expense-vpc.az_info
# }

# output "vpc_id" {
#     value = module.expense-vpc.route_id
# }

# output "def_vpc_id" {
#     value = module.expense-vpc.default_vpc_id
# }

# output "def_vpc_cidr" {
#     value = module.expense-vpc.default_vpc_cidr
# }

# output "peering_id" {
#     value = module.expense-vpc.vpc_peering_connection_id
  
# }

# output "public_route_id" {
#     value = module.expense-vpc.pub_id
  
# }

# output "default_route_table_id" {
#   value = module.expense-vpc.def-route-table-id
# }
output "ex-vpc-id" {
    value = module.expense-vpc.vpc_id
  
}

output "pub_sub_ids" {
  value = module.expense-vpc.public_subnet_ids
}
output "pri_sub_ids" {
  value = module.expense-vpc.private_subnet_ids
}
output "db_sub_ids" {
  value = module.expense-vpc.database_subnet_ids
}
