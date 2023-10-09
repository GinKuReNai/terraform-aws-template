variable "project" {
    type = string
    description = "Project name"
}

variable "environment" {
    type = string
    description = "Environment name"
}

variable "github_account_name" {
  type = string
  description = "GitHub Account Name"
}

variable "github_repository_name" {
  type = string
  description = "GitHub Repository Name"
}

variable "github_repository_url" {
  type = string
  description = "GitHub Repository URL"
}

variable "ecr_repository_name" {
  type = string
  description = "ECR Repository Name"
}

variable "ecs_cluster_name" {
  type = string
  description = "ECS Cluster Name"
}

variable "ecs_service_name" {
  type = string
  description = "ECS Service Name"
}

variable "prod_alb_listener_arn" {
  type = string
  description = "ALB Listener ARN(Blue : prod)"
}

variable "test_alb_listener_arn" {
  type = string
  description = "ALB Listener ARN(Green : test)"
}

variable "prod_alb_target_group_name" {
  type = string
  description = "ALB Target Group Name(Blue : prod)"
}

variable "test_alb_target_group_name" {
  type = string
  description = "ALB Target Group Name(Green : test)"
}

variable "codebuild_role_arn" {
  type = string
  description = "CodeBuild Role ARN"
}

variable "codedeploy_role_arn" {
  type = string
  description = "CodeDeploy Role ARN"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
