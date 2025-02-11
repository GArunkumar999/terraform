data "aws_availability_zones" "available" {
    state = "available"
   
}

data "aws_route_table" "default" {
  vpc_id = local.default_vpc_id
  filter {
    name = "association.main"
    values = ["true"]
  }
}




