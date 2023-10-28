output "codebuild_arn" {
  description = "CodeBuild ARN"
  value = aws_codebuild_project.codebuild.arn
}

output "codedeploy_arn" {
  description = "CodeDeploy ARN"
  value = aws_codedeploy_app.deploy.arn
}

output "codepipeline_log_group_arn" {
  description = "CodePipeline CloudWatch Log Group ARN"
  value = aws_cloudwatch_log_group.codepipeline_log_group.arn
}

output "codepipeline_artifact_bucket_arn" {
  description = "S3 Bucket ARN For Artifact made in deploying"
  value = aws_s3_bucket.codepipeline_artifact_bucket.arn
}
