resource "aws_route53_record" "back-alb" {
  zone_id = "Z0720927H41Q39EST49L"
  name    = "back.devopslearning.fun"
  type    = "A"

  alias {
    name                   = "internal-back-alb-933382751.us-east-1.elb.amazonaws.com"
    zone_id                = "Z35SXDOTRQ7X7K"
    evaluate_target_health = false
  }
}


module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
version = "~> 3.0"

  zone_name = "devopslearning.fun"

  records = [
    {
      name    = "back.devop"
      type    = "A"
      alias   = {
        name    = module.alb.dns_name
        zone_id = module.alb.zone_id
      }
      allow_overwrite = true
    }
  ]
}