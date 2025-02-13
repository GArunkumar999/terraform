module "alb" {
  source = "terraform-aws-modules/alb/aws"
enable_deletion_protection = false
  internal = true
  create_security_group = false
  security_groups = [data.aws_ssm_parameter.back-alb-id.value]
 name    = "back-alb"
  vpc_id  = data.aws_ssm_parameter.vpc_id.value
  subnets = split(",", data.aws_ssm_parameter.private_subnet_ids.value)

  tags = {
    Name = "${var.project}-${var.environment}-back-alb"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = module.alb.arn
  port              = "80"
  protocol          = "HTTP"
  

  default_action {
        type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>HELLO FROM ALB</h1>"
      status_code  = "200"
    }
  }
}