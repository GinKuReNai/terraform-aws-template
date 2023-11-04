variable "project" {
    type = string
    description = "Project name"
}

variable "environment" {
    type = string
    description = "Environment name"
}

variable "ecr_arn" {
    type = string
    description = "ECR ARN"
}

variable "ecr_repository_name" {
  type = string
  description = "ECR Repository Name"
}

variable "codebuild_arn" {
    type = string
    description = "CodeBuild ARN"
}

variable "codedeploy_arn" {
  type = string
  description = "CodeDeploy ARN"
}

variable "codedeploy_app_name" {
  type = string
  description = "CodeDeploy Application Name"
}

variable "codedeploy_deployment_config_name" {
  type = string
  description = "CodeDeploy Deployment Config Name"
}

variable "codedeploy_deployment_group_name" {
  type = string
  description = "CodeDeploy Deployment Group Name"
}

variable "codepipeline_log_group_arn" {
    type = string
    description = "CodePipeline Log Group ARN"
}

variable "codepipeline_artifact_bucket_arn" {
    type = string
    description = "S3 Bucket ARN For CodePipeline Artifact"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
