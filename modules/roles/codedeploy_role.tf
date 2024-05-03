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
      test     = "StringEqualsIfExists"
      variable = "iam:PassedToService"
      values = [
        "ecs-tasks.amazonaws.com"
      ]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "ecs:DescribeTaskDefinition",
      "ecs:RegisterTaskDefinition",
      "ecs:CreateTaskSet",
      "ecs:UpdateTaskSet",
      "ecs:UpdateServicePrimaryTaskSet",
      "ecs:DescribeTaskSets",
      "ecs:DeleteTaskSet",
    ]
    # リソースレベルの指定はサポートされていないため、全リソースを対象とする
    # https://docs.aws.amazon.com/ja_jp/service-authorization/latest/reference/list_amazonelasticcontainerservice.html
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecs:DescribeServices",
    ]
    resources = [
      "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:service/*",
    ]
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
    # リソースレベルの指定はサポートされていないため、全リソースを対象とする
    # https://docs.aws.amazon.com/ja_jp/service-authorization/latest/reference/list_awselasticloadbalancingv2.html
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
