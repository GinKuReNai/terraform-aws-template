# ---------------------------------------
# Security Group(ALB)
# ---------------------------------------
resource "aws_security_group" "alb_sg" {
  name = "${var.project}-${var.environment}-alb-sg"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "alb_sg_ingress_rule" {
  security_group_id = aws_security_group.alb_sg.id
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
  tags = {
    Name = "${var.project}-${var.environment}-alb-sg-ingress-rule"
  }
}

resource "aws_vpc_security_group_egress_rule" "alb_sg_egress_rule" {
  security_group_id = aws_security_group.alb_sg.id
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
  tags = {
    Name = "${var.project}-${var.environment}-alb-sg-egress-rule"
  }
}

# ---------------------------------------
# Security Group(ECS)
# ---------------------------------------
resource "aws_security_group" "ecs_sg" {
  name = "${var.project}-${var.environment}-ecs-sg"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "ecs_sg_ingress_rule_1a" {
  security_group_id = aws_security_group.ecs_sg.id
  from_port = 8000
  to_port = 8000
  ip_protocol = "tcp"
  cidr_ipv4 = var.cidr_block.public_subnet_ingress_1a
  tags = {
    Name = "${var.project}-${var.environment}-ecs-sg-ingress-rule"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_sg_ingress_rule_1c" {
  security_group_id = aws_security_group.ecs_sg.id
  from_port = 8000
  to_port = 8000
  ip_protocol = "tcp"
  cidr_ipv4 = var.cidr_block.public_subnet_ingress_1c
  tags = {
    Name = "${var.project}-${var.environment}-ecs-sg-ingress-rule"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_sg_ingress_rule_for_ecr_1a" {
  security_group_id = aws_security_group.ecs_sg.id
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
  cidr_ipv4 = var.cidr_block.private_subnet_egress_1a
  tags = {
    Name = "${var.project}-${var.environment}-ecs-sg-ingress-rule-for-ecr"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_sg_ingress_rule_for_ecr_1c" {
  security_group_id = aws_security_group.ecs_sg.id
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
  cidr_ipv4 = var.cidr_block.private_subnet_egress_1c
  tags = {
    Name = "${var.project}-${var.environment}-ecs-sg-ingress-rule-for-ecr"
  }
}

resource "aws_vpc_security_group_egress_rule" "ecs_sg_egress_rule" {
  security_group_id = aws_security_group.ecs_sg.id
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
  tags = {
    Name = "${var.project}-${var.environment}-ecs-sg-egress-rule"
  }
}

# ---------------------------------------
# Security Group(VPC Endpoint)
# ---------------------------------------
resource "aws_security_group" "vpc_endpoint_sg" {
  name = "${var.project}-${var.environment}-vpc-endpoint-sg"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "vpc_endpoint_sg_ingress_rule_1a" {
  security_group_id = aws_security_group.vpc_endpoint_sg.id
  # ECR operations are performed using HTTPS
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
  cidr_ipv4 = var.cidr_block.private_subnet_application_1a
  tags = {
    Name = "${var.project}-${var.environment}-vpc-endpoint-sg-ingress-rule"
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpc_endpoint_sg_ingress_rule_1c" {
  security_group_id = aws_security_group.vpc_endpoint_sg.id
  # ECR operations are performed using HTTPS
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
  cidr_ipv4 = var.cidr_block.private_subnet_application_1c
  tags = {
    Name = "${var.project}-${var.environment}-vpc-endpoint-sg-ingress-rule"
  }
}

resource "aws_vpc_security_group_egress_rule" "vpc_endpoint_sg_egress_rule" {
  security_group_id = aws_security_group.vpc_endpoint_sg.id
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
  tags = {
    Name = "${var.project}-${var.environment}-vpc-endpoint-sg-egress-rule"
  }
}

# ---------------------------------------
# Security Group(RDS:Aurora MySQL)
# ---------------------------------------
resource "aws_security_group" "rds_sg" {
  name = "${var.project}-${var.environment}-rds-sg"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "rds_sg_ingress_rule_1a" {
  security_group_id = aws_security_group.rds_sg.id
  # Aurora MySQL port is 3306
  from_port = 3306
  to_port = 3306
  ip_protocol = "tcp"
  cidr_ipv4 = var.cidr_block.private_subnet_application_1a
  tags = {
    Name = "${var.project}-${var.environment}-rds-sg-ingress-rule"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds_sg_ingress_rule_1c" {
  security_group_id = aws_security_group.rds_sg.id
  # Aurora MySQL port is 3306
  from_port = 3306
  to_port = 3306
  ip_protocol = "tcp"
  cidr_ipv4 = var.cidr_block.private_subnet_application_1c
  tags = {
    Name = "${var.project}-${var.environment}-rds-sg-ingress-rule"
  }
}

resource "aws_vpc_security_group_egress_rule" "rds_sg_egress_rule" {
  security_group_id = aws_security_group.rds_sg.id
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
  tags = {
    Name = "${var.project}-${var.environment}-rds-sg-egress-rule"
  }
}
