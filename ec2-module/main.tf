resource "aws_instance" "server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.sg_id]

  tags = merge(
    var.common_tags,
    var.usecase
  )
}

 