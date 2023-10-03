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
    description = "ECR Arn"
}

variable "codebuild_arn" {
    type = string
    description = "CodeBuild Arn"
}

variable "codepipeline_log_group_arn" {
    type = string
    description = "CodePipeline Log Group Arn"
}

variable "codepipeline_artifact_bucket_arn" {
    type = string
    description = "S3 Bucket Arn For CodePipeline Artifact"
}
