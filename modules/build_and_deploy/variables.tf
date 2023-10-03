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

variable "ecr_repository_name" {
  type = string
  description = "ECR Repository Name"
}

variable "codebuild_role_arn" {
  type = string
  description = "CodeBuild Role ARN"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
