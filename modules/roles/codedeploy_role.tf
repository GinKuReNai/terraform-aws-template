# ---------------------------------------
# Assume Role
# ---------------------------------------
resource "aws_iam_role" "codedeploy_role" {
  name = "${var.project}-${var.environment}-codedeploy-role"
  assume_role_policy = data.aws_iam_policy_document.codedeploy_role_document.json
}

# ---------------------------------------
# Assume Role Policy Document
# ---------------------------------------
data "aws_iam_policy_document" "codedeploy_role_document" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# ---------------------------------------
# IAM Policy
# ---------------------------------------
resource "aws_iam_role_policy" "codedeploy_role_policy" {
  name = "${var.project}-${var.environment}-codedeploy-role-policy"
  role = aws_iam_role.codedeploy_role.name
  policy = data.aws_iam_policy_document.codedeploy_role_policy_document.json
}

# ---------------------------------------
# IAM Policy Document
# ---------------------------------------
data "aws_iam_policy_document" "codedeploy_role_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = ["*"]
    condition {
      test = "StringEqualsIfExists"
      variable = "iam:PassedToService"
      values = [
        "ecs-tasks.amazonaws.com"
      ]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "ecs:DescribeServices",
      "ecs:CreateTaskSet",
      "ecs:UpdateServicePrimaryTaskSet",
      "ecs:DeleteTaskSet",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:ModifyRule"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:DescribeAlarms"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "codedeploy:*"
    ]
    resources = [var.codedeploy_arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]
    resources = [
      var.codepipeline_artifact_bucket_arn,
      "${var.codepipeline_artifact_bucket_arn}/*"
    ]
  }
}
