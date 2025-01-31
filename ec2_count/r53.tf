resource "aws_route53_record" "expense" {
  count = length(var.names)
  allow_overwrite = true
  zone_id   = "Z072902229T9FMIKBXOSF"  # Replace with your Hosted Zone ID
  name      = "${var.names[count.index]}.${var.domain}"  # Correct name (mysql, backend, frontend)
  type      = "A"
  ttl       = 60  # Set TTL to 60 seconds (or adjust as needed)
  records   = [aws_instance.newinstance[count.index].private_ip]  # Use private IP of instance
}