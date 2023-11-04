output "codebuild_arn" {
  description = "CodeBuild ARN"
  value = aws_codebuild_project.codebuild.arn
}

output "codedeploy_arn" {
  description = "CodeDeploy ARN"
  value = aws_codedeploy_app.deploy.arn
}

output "codedeploy_app_name" {
  description = "CodeDeploy Application Name"
  value = aws_codedeploy_app.deploy.name
}

output "codedeploy_deployment_config_name" {
  description = "CodeDeploy Deployment Config Name"
  value = aws_codedeploy_deployment_config.deployment_config.deployment_config_name
}

output "codedeploy_deployment_group_name" {
  description = "CodeDeploy Deployment Group Name"
  value = aws_codedeploy_deployment_group.deployment_group.deployment_group_name
}

output "codepipeline_log_group_arn" {
  description = "CodePipeline CloudWatch Log Group ARN"
  value = aws_cloudwatch_log_group.codepipeline_log_group.arn
}

output "codepipeline_artifact_bucket_arn" {
  description = "S3 Bucket ARN For Artifact made in deploying"
  value = aws_s3_bucket.codepipeline_artifact_bucket.arn
}
