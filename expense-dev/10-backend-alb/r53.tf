# resource "aws_route53_record" "back-alb" {
#   zone_id = "Z07417503UK41D4DL7V7V"
#   name    = "back.devopslearning.fun"
#   type    = "A"
 
#   alias {
#     name                   = "internal-back-alb-562897397.ap-south-1.elb.amazonaws.com"
#     zone_id                = "ZP97RAFLXTNZK"
#     evaluate_target_health = false
#   }
# }


# module "records" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
  # version = "~> 3.0"

#   zone_name = "devopslearning.fun"

#   records = [
#     {
#       name    = "back.devop"
#       type    = "A"
#       alias   = {
#         name    = module.alb.dns_name
#         zone_id = module.alb.zone_id
#       }
#       allow_overwrite = true
#     }
#   ]
# }