output "ecr_arn" {
  description = "ECR ARN"
  value = aws_ecr_repository.ecr.arn
}

output "ecr_repository_name" {
  description = "ECR Repository Name"
  value = aws_ecr_repository.ecr.name
}
