resource "aws_route53_record" "expense" {
  count = length(var.instances)
  zone_id = "Z07417503UK41D4DL7V7V"
  name    = var.instances[count.index] == "frontend" && terraform.workspace == "prod" ? var.domain_name : "${var.instances[count.index]}-${terraform.workspace}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = var.instances[count.index] == "frontend" && terraform.workspace == "prod" ? [aws_instance.expense[count.index].public_ip] : [aws_instance.expense[count.index].private_ip]
}