# output "vpc_ids"{
#     value = aws_vpc.vpc
  
# }

# output "az_info" {

#  value = data.aws_availability_zones.available.names
# }

# output "route_id"{
#     value = aws_vpc.vpc.main_route_table_id
  
# }

# output "default_vpc_id" {
#     value = data.aws_vpc.default.id
  
# }

# output "default_vpc_cidr" {
#     value = data.aws_vpc.default.cidr_block
  
# }

# output "vpc_peering_connection_id" {
#     value = aws_vpc_peering_connection.vpc[0].id
  
# }

# output "pub_id" {
#   value = aws_route_table.public-route.id
# }

# output "def-route-table-id" {
#     value = data.aws_route_table.default.route_table_id
  
# }
output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public-subnet[*].id
  
}
output "private_subnet_ids" {
  value = aws_subnet.private-subnet[*].id
  
}
output "database_subnet_ids" {
  value = aws_subnet.database-subnet[*].id
  
}