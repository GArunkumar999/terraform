# creating application load balancer for backend

module "web-alb" {
  source                     = "terraform-aws-modules/alb/aws"
  enable_deletion_protection = false
  internal                   = false
  create_security_group      = false
  security_groups            = [data.aws_ssm_parameter.web__alb_sg_id.value]
  name                       = "web-alb"
  vpc_id                     = data.aws_ssm_parameter.vpc_id.value
  subnets                    = split(",", data.aws_ssm_parameter.public_subnet_ids.value)

  tags = {
    Name = "${var.project}-${var.environment}-web-alb"
  }
}

# creating listener for backend alb for fixed response

resource "aws_lb_listener" "https" {
  load_balancer_arn = module.web-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_ssm_parameter.web_certificate_arn.value


  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>HELLO FROM WEB ALB</h1>"
      status_code  = "200"
    }
  }
}

# creating backend target group

resource "aws_lb_target_group" "frontend_tg" {
  name        = "nginx"
  target_type = "instance"
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  health_check {
    healthy_threshold   = 2
    interval            = 10
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

}

# creating listner rule for backend alb to target backend target group

resource "aws_lb_listener_rule" "frontend_header" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }


  condition {
    host_header {
      values = ["${var.project}-${var.environment}.devopslearning.fun"]
    }
  }
}


#launch template
resource "aws_launch_template" "frontend_nginx" {
  name = "frontend_nginx"

  image_id = data.aws_ssm_parameter.frontend_ami_id.value

  instance_type = "t2.micro"

  placement {
    availability_zone = "us-east-1a"
  }
  vpc_security_group_ids = [data.aws_ssm_parameter.frontend_sg_id.value]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "nginx"
    }
  }

}

#creating auto-scaling-group
resource "aws_autoscaling_group" "frontend_nginx" {
  name                      = "frontend_nginx"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 120
  health_check_type         = "ELB"
  desired_capacity          = 1
  launch_template {
    id      = aws_launch_template.frontend_nginx.id
    version = "$Latest"
  }
  vpc_zone_identifier = [data.aws_ssm_parameter.public_subnet_ids.value]
  target_group_arns   = [aws_lb_target_group.frontend_tg.arn]
  timeouts {
    delete = "5m"
  }

  tag {
    key                 = "project"
    value               = "expense"
    propagate_at_launch = false
  }

  tag {
    key                 = "environment"
    value               = "dev"
    propagate_at_launch = false
  }

  tag {
    key                 = "name"
    value               = "frontend-nginx"
    propagate_at_launch = false
  }

}

resource "aws_autoscaling_policy" "cpu_policy" {
  autoscaling_group_name = aws_autoscaling_group.frontend_nginx.name
  policy_type            = "TargetTrackingScaling"

  name                      = "cpu-target-tracking-policy"
  scaling_adjustment        = 0 # No manual adjustment, just tracking
  adjustment_type           = "TargetTrackingScaling"
  estimated_instance_warmup = 120 # Warmup period to avoid continuous scaling

  target_tracking_configuration {
    target_value = 70 # Target CPU utilization percentage
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }

}




