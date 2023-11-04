# ---------------------------------------
# Assume Role
# ---------------------------------------
resource "aws_iam_role" "codebuild_role" {
  name = "${var.project}-${var.environment}-codebuild-role"
  assume_role_policy = data.aws_iam_policy_document.codebuild_role_document.json
}

# ---------------------------------------
# Assume Role Policy Document
# ---------------------------------------
data "aws_iam_policy_document" "codebuild_role_document" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# ---------------------------------------
# IAM Policy
# ---------------------------------------
resource "aws_iam_role_policy" "codebuild_role_policy" {
  name = "${var.project}-${var.environment}-codebuild-role-policy"
  role = aws_iam_role.codebuild_role.name
  policy = data.aws_iam_policy_document.codebuild_role_policy_document.json
}

# ---------------------------------------
# IAM Policy Document
# ---------------------------------------
data "aws_iam_policy_document" "codebuild_role_policy_document" {

  statement {
    effect = "Allow"
    actions = [
      "codestar-connections:UseConnection"
    ]
    resources = ["arn:aws:codestar-connections:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:connection/*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken"
    ]
    # Resource chooses a wildcard
    # because the ecr:GetAuthorizationToken action provides an authorization token at the AWS account level, not at the repository level
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:CompleteLayerUpload",
        "ecr:DescribeImages",
        "ecr:DescribeRepositories",
        "ecr:GetDownloadUrlForLayer",
        "ecr:InitiateLayerUpload",
        "ecr:ListImages",
        "ecr:PutImage",
        "ecr:UploadLayerPart"
    ]
    resources = [var.ecr_arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "codebuild:StartBuild",
      "codebuild:StopBuild",
      "codebuild:StartBuildBatch",
      "codebuild:StopBuildBatch",
      "codebuild:RetryBuild",
      "codebuild:RetryBuildBatch",
      "codebuild:BatchGet*",
      "codebuild:GetResourcePolicy",
      "codebuild:DescribeTestCases",
      "codebuild:DescribeCodeCoverages",
      "codebuild:List*",
      "codebuild:CreateReportGroup",
      "codebuild:CreateReport",
      "codebuild:UpdateReport",
      "codebuild:BatchPutTestCases",
      "codebuild:BatchPutCodeCoverages"
    ]
    resources = [var.codebuild_arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
    ]
    resources = [
      var.codepipeline_log_group_arn,
      "${var.codepipeline_log_group_arn}:*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]
    resources = [
      var.codepipeline_artifact_bucket_arn,
      "${var.codepipeline_artifact_bucket_arn}/*"
    ]
  }
}
