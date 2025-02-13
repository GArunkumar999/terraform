# resource "aws_vpc_peering_connection" "default" {
#   count = var.is_vpc_peering_required ? 1 : 0
#   peer_vpc_id   = aws_vpc.vpc.id
#   vpc_id        = local.default_vpc_id
#   auto_accept   = true

#   tags = merge(
#     var.common_tags,
#     {
#     Name = "VPC Peering"
#   }
#   )
# }

# resource "aws_route" "public-subnet-peering" {
#   count = var.is_vpc_peering_required ? 1 : 0
#   route_table_id            = aws_route_table.public-route.id
#   destination_cidr_block    = local.def_vpc_cidr
#   vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
# }

# resource "aws_route" "private-subnet-peering" {
#    count = var.is_vpc_peering_required ? 1 : 0
#   route_table_id            = aws_route_table.private-route.id
#   destination_cidr_block    = local.def_vpc_cidr
#   vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
# }
# resource "aws_route" "database-subnet-peering" {
#   count = var.is_vpc_peering_required ? 1 : 0
#   route_table_id            = aws_route_table.database-route.id
#   destination_cidr_block    = local.def_vpc_cidr
#   vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
# }

# resource "aws_route" "default-subnet-peering" {
#   count = var.is_vpc_peering_required ? 1 : 0
#   route_table_id            = local.default_vpc_route_table_id
#   destination_cidr_block    = aws_vpc.vpc.cidr_block
#   vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
# }


