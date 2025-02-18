resource "aws_route53_record" "back-alb" {
  zone_id = "Z0720927H41Q39EST49L"
  name    = "devopslearning.fun"
  type    = "A"
  records = [aws_instance.frontend.public_ip]
  ttl = 1


}