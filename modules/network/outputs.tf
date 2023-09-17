output "ecs_sg_arn" {
  description = "ARN of IAM role to be assigned to ECS"
  value = aws_security_group.ecs_sg.arn
}

output "ecs_subnet_1a_id" {
  description = "Subnet ARN(1a)"
  value = aws_subnet.private-subnet-application-1a.id
}

output "ecs_subnet_1c_id" {
  description = "Subnet ARN(1c)"
  value = aws_subnet.private-subnet-application-1c.id
}

output "alb_target_group_for_blue_arn" {
  description = "ARN of the target group of ALB (Blue)"
  value = aws_lb_target_group.alb_target_group_for_blue.arn
}

output "alb_target_group_for_green_arn" {
  description = "arn of the target group of alb (Green)"
  value = aws_lb_target_group.alb_target_group_for_green.arn
}

