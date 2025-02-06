locals {
  value = slice(data.aws_availability_zones.available.names , 0 , 2)
  default_vpc_id = data.aws_vpc.default.id
  def_vpc_cidr = data.aws_vpc.default.cidr_block
  default_vpc_route_table_id = data.aws_route_table.default.route_table_id
  
}