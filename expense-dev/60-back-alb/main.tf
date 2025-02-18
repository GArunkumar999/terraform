# creating application load balancer for backend

module "alb" {
  source                     = "terraform-aws-modules/alb/aws"
  enable_deletion_protection = false
  internal                   = true
  create_security_group      = false
  security_groups            = [data.aws_ssm_parameter.back-alb-id.value]
  name                       = "back-alb"
  vpc_id                     = data.aws_ssm_parameter.vpc_id.value
  subnets                    = split(",", data.aws_ssm_parameter.private_subnet_ids.value)

  tags = {
    Name = "${var.project}-${var.environment}-back-alb"
  }
}

# creating listener for backend alb for fixed response

resource "aws_lb_listener" "http" {
  load_balancer_arn = module.alb.arn
  port              = "8080"
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

# creating listner rule for backend alb to target backend target group

resource "aws_lb_listener_rule" "backend_header" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }


  condition {
    host_header {
      values = ["backend.devopslearning.fun"]
    }
  }
}

# creating backend target group

resource "aws_lb_target_group" "backend_tg" {
  name        = "nodejs"
  target_type = "instance"
  port        = "8080"
  protocol    = "HTTP"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
   health_check {
    healthy_threshold   = 2          
    interval            = 10       
    path                = "/health"    
    port                = "8080"                                                
    protocol            = "HTTP"         
    timeout             = 5              
    unhealthy_threshold = 2
    matcher="200-299"
  }

}



#launch template
resource "aws_launch_template" "backend_nodejs" {
  name = "backend_nodejs"

  image_id = data.aws_ssm_parameter.backend_ami_id.value

  instance_type = "t2.micro"

  placement {
    availability_zone = "us-east-1a"
  }
  vpc_security_group_ids = [data.aws_ssm_parameter.backend_sg_id.value]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "nodejs"
    }
  }

}

#creating auto-scaling-group
resource "aws_autoscaling_group" "backend_nodejs" {
  name                      = "backend_nodejs"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 120
  health_check_type         = "ELB"
  desired_capacity          = 1
    launch_template {
    id      = aws_launch_template.backend_nodejs.id
    version = "$Latest"
  }
  vpc_zone_identifier= [data.aws_ssm_parameter.private_subnet_ids.value]
  target_group_arns=[aws_lb_target_group.backend_tg.arn]
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
    value               = "back-nodejs"
    propagate_at_launch = false
  }

}

resource "aws_autoscaling_policy" "cpu_policy" {
  autoscaling_group_name = aws_autoscaling_group.backend_nodejs.name
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