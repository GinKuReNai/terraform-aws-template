# ---------------------------------------
# CodeBuild
# ---------------------------------------
resource "aws_codebuild_project" "codebuild" {
  name = "${var.project}-${var.environment}-codebuild"
  description = "for ${var.project} ${var.environment} codebuild"
  build_timeout = 5
  service_role = var.codebuild_role_arn

  artifacts {
    # Specify "NO_ARTIFACT" to push to ECR
    type = "NO_ARTIFACTS"
  }

  cache {
    type = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    # Select Amazon Linux 2 as the Docker image to run the build
    image = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type = "LINUX_CONTAINER"
    # Pull Docker images using credentials managed by CodeBuild
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name = "AWS_REGION"
      value = data.aws_region.current.name
    }

    environment_variable {
      name = "ECR_URL"
      value = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com"
    }

    environment_variable {
      name = "REPOSITORY_URL"
      value = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.ecr_repository_name}"
    }

    environment_variable {
      name = "IMAGE_TAG"
      value = "latest"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.codepipeline_log_group.name
      stream_name = "build-log"
    }
  }
}
