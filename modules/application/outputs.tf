output "ecr_arn" {
  description = "ECR ARN"
  value = aws_ecr_repository.ecr.arn
}

output "ecr_repository_name" {
  description = "ECR Repository Name"
  value = aws_ecr_repository.ecr.name
}

output "ecs_cluster_name" {
  description = "ECS Cluster Name"
  value = aws_ecs_cluster.ecs_cluster.name
}

output "ecs_service_name" {
  description = "ECS Service Name"
  value = aws_ecs_service.ecs_service.name
}

output "prod_alb_target_group_name" {
  description = "ALB Target Group Name(Blue : prod)"
  value = aws_lb_target_group.alb_target_group_for_prod.name
}

output "test_alb_target_group_name" {
  description = "ALB Target Group Name(Green : test)"
  value = aws_lb_target_group.alb_target_group_for_test.name
}

output "prod_alb_listener_arn" {
  description = "ALB Listener ARN(Blue : prod)"
  value = aws_lb_listener.alb_listener_for_prod.arn
}

output "test_alb_listener_arn" {
  description = "ALB Listener ARN(Green : test)"
  value = aws_lb_listener.alb_listener_for_test.arn
}
