resource "aws_route53_record" "expense" {
  count = length(var.instances)
  zone_id = "Z093094737LZEXBZE8OCA"
  name    = var.instances[count.index] == "frontend" && var.environment == "prod" ? var.domain_name : "${var.instances[count.index]}-${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = var.instances[count.index] == "frontend" && var.environment == "prod" ? [aws_instance.expense[count.index].public_ip] : [aws_instance.expense[count.index].private_ip]
}