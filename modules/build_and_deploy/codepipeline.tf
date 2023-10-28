# ---------------------------------------
# Codepipeline
# ---------------------------------------
resource "aws_codepipeline" "pipeline" {
  name = "${var.project}-${var.environment}-pipeline"
  role_arn = var.codepipeline_role_arn

  stage {
    name = "Source"

    action {
      name = "Source"
      category = "Source"
      owner = "AWS"
      provider = "CodeStarSourceConnection"
      version = 1
      output_artifacts = ["SourceArtifact"]

      configuration = {
        ConnectionArn = aws_codestarconnections_connection.github.arn
        FullRepositoryId = "${var.github_account_name}/${var.github_repository_name}"
        BranchName = var.github_repository_branch
        # Select "CODEBUILD_CLONE_REF" since CodeBuild is used in the Build stage
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name = "Build"
      category = "Build"
      owner = "AWS"
      provider = "CodeBuild"
      input_artifacts = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version = 1

      configuration = {
        ProjectName = aws_codebuild_project.codebuild.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name = "Deploy"
      category = "Deploy"
      owner = "AWS"
      provider = "CodeDeploy"
      input_artifacts = ["BuildArtifact"]
      version = 1

      configuration = {
        ApplicationName = aws_codedeploy_app.deploy.name
        DeploymentGroupName = aws_codedeploy_deployment_group.deployment_group.deployment_group_name
      }
    }
  }

  artifact_store {
    location = aws_s3_bucket.codepipeline_artifact_bucket.id
    type = "S3"
  }
}
