# ---------------------------------------
# Application Load Balancer(ALB)
# ---------------------------------------
resource "aws_lb" "alb" {
  name = "${var.project}-${var.environment}-alb"
  internal = false
  load_balancer_type = "application"
  # todo: SGを設定したら、該当のSGのidを設定すること
  security_groups = []
  subnets = [
    aws_subnet.public-subnet-ingress-1a.id,
    aws_subnet.public-subnet-ingress-1c.id
  ]
  ip_address_type = "ipv4"

  tags = {
    Name = "${var.project}-${var.environment}-alb"
  }
}

# ---------------------------------------
# ALB Target Group(Blue)
# ---------------------------------------
resource "aws_lb_target_group" "alb_target_group_for_blue" {
  name = "${var.project}-${var.environment}-alb-target-group-for-blue"
  # When using ECS, be sure to select "ip"
  # Because tasks that use the awsvpc network mode are associated with ENI
  target_type = "ip"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc.id
  registration_delay = 300

  tags = {
    Name = "${var.project}-${var.environment}-alb-target-group-for-blue"
  }

  health_check {
    interval = 15
    path = "/"
    # If "traffic-port" is specified, the port number specified in port above is used
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 5
    # Number of health check executions until normal judgment is made
    healthy_threshold = 3
    # Number of health check executions until an abnormality is determined
    unhealthy_threshold = 2
    matcher = "200, 301"
  }

  # ALB, target group created at the same time as the ECS service will cause an error,
  # so use depends_on to describe the dependencies
  depends_on = [ aws_lb.alb ]
}

# ---------------------------------------
# ALB Target Group(Green)
# ---------------------------------------
resource "aws_lb_target_group" "alb_target_group_for_green" {
  name = "${var.project}-${var.environment}-alb-target-group-for-green"
  # When using ECS, be sure to select "ip"
  # Because tasks that use the awsvpc network mode are associated with ENI
  target_type = "ip"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc.id
  registration_delay = 300

  tags = {
    Name = "${var.project}-${var.environment}-alb-target-group-for-green"
  }

  health_check {
    interval = 15
    path = "/"
    # If "traffic-port" is specified, the port number specified in port above is used
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 5
    # Number of health check executions until normal judgment is made
    healthy_threshold = 3
    # Number of health check executions until an abnormality is determined
    unhealthy_threshold = 2
    matcher = "200, 301"
  }

  # ALB, target group created at the same time as the ECS service will cause an error,
  # so use depends_on to describe the dependencies
  depends_on = [ aws_lb.alb ]
}


# No need for 'aws_lb_target_group_attachment' resource

# ---------------------------------------
# ALB Listener(Blue)
# ---------------------------------------
resource "aws_lb_listener" "alb_listener_for_blue" {
  load_balancer_arn = aws_lb.alb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group_for_blue.arn
  }
}

# ---------------------------------------
# ALB Listener(Green)
# ---------------------------------------
resource "aws_lb_listener" "alb_listener_for_green" {
  load_balancer_arn = aws_lb.alb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group_green.arn
  }
}