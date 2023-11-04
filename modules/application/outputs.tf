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

output "ecs_task_definition_arn" {
  description = "ECS Task Definition ARN"
  value = aws_ecs_task_definition.task_definition.arn
}
