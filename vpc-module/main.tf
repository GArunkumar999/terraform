resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = merge(
    var.common_tags,
    var.purpose,
    {
        Name = "VPC"
    }
  )
  
}

