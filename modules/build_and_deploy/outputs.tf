output "codebuild_arn" {
  description = "CodeBuild Arn"
  value = aws_codebuild_project.codebuild.arn
}

output "codepipeline_log_group_arn" {
  description = "CodePipeline CloudWatch Log Group Arn"
  value = aws_cloudwatch_log_group.codepipeline_log_group.arn
}

output "codepipeline_artifact_bucket_arn" {
  description = "S3 Bucket Arn For Artifact made in deploying"
  value = aws_s3_bucket.codepipeline_artifact.arn
}
