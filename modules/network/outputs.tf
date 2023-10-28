output "ecs_sg_id" {
  description = "ID of IAM role to be assigned to ECS"
  value = aws_security_group.ecs_sg.id
}

output "ecs_subnet_1a_id" {
  description = "Subnet ARN(1a)"
  value = aws_subnet.private_subnet_application_1a.id
}

output "ecs_subnet_1c_id" {
  description = "Subnet ARN(1c)"
  value = aws_subnet.private_subnet_application_1c.id
}

output "db_subnet_group_name" {
  description = "Database Subnet Group Name"
  value = aws_db_subnet_group.db_subnet_group.name
}

output "db_security_group_id" {
  description = "Database Security Group ID"
  value = aws_security_group.rds_sg.id
}

output "alb_listener_for_prod_arn" {
  description = "ARN of the listener of ALB (Blue)"
  value = aws_lb_listener.alb_listener_for_prod.arn
}

output "alb_listener_for_test_arn" {
  description = "ARN of the listener of ALB (Green)"
  value = aws_lb_listener.alb_listener_for_test.arn
}

output "alb_target_group_for_prod_arn" {
  description = "ARN of the target group of ALB (Blue)"
  value = aws_lb_target_group.alb_target_group_for_prod.arn
}

output "alb_target_group_for_test_arn" {
  description = "arn of the target group of alb (Green)"
  value = aws_lb_target_group.alb_target_group_for_test.arn
}

output "alb_target_group_for_prod_name" {
  description = "Name of the target group of ALB (Blue)"
  value = aws_lb_target_group.alb_target_group_for_prod.name
}

output "alb_target_group_for_test_name" {
  description = "Name of the target group of ALB (Green)"
  value = aws_lb_target_group.alb_target_group_for_test.name
}
