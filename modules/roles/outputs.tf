output "vpc_flow_logs_role_arn" {
  description = "VPC Flow Logs Role ARN"
  value = aws_iam_role.vpc_flow_logs_role.arn
}

output "ecs_task_role_arn" {
  description = "ECS Task Role ARN"
  value = aws_iam_role.ecs_task_role.arn
}

output "ecs_task_execution_role_arn" {
  description = "ECS Task Execution Role ARN"
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "rds_monitoring_role_arn" {
  description = "RDS Monitoring Role ARN"
  value = aws_iam_role.rds_monitoring_role.arn
}

output "codebuild_role_arn" {
  description = "CodeBuild Role ARN"
  value = aws_iam_role.codebuild_role.arn
}

output "codedeploy_role_arn" {
  description = "CodeDeploy Role ARN"
  value = aws_iam_role.codedeploy_role.arn
}

output "codepipeline_role_arn" {
  description = "CodePipeline Role ARN"
  value = aws_iam_role.codepipeline_role.arn
}

output "autoscaling_role_arn" {
  description = "AutoScaling Role ARN"
  value = aws_iam_role.autoscaling_role.arn
}
