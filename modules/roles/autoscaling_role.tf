# ---------------------------------------
# Assume Role
# ---------------------------------------
resource "aws_iam_role" "autoscaling_role" {
  name = "${var.project}-${var.environment}-autoscaling-role"
  assume_role_policy = data.aws_iam_policy_document.autoscaling_role_document.json
}

# ---------------------------------------
# Assume Role Policy Document
# ---------------------------------------
data "aws_iam_policy_document" "autoscaling_role_document" {
    statement {
      effect = "Allow"
      principals {
        type = "Service"
        identifiers = ["application-autoscaling.amazonaws.com"]
      }
      actions = ["sts:AssumeRole"]
    }
}

# ---------------------------------------
# IAM Policy
# ---------------------------------------
resource "aws_iam_policy" "autoscaling_role_policy" {
    name = "${var.project}-${var.environment}-autoscaling-role-policy"
    policy = data.aws_iam_policy_document.autoscaling_role_policy_document.json
}

# ---------------------------------------
# IAM Policy Document
# ---------------------------------------
data "aws_iam_policy_document" "autoscaling_role_policy_document" {
    statement {
      effect = "Allow"
      actions = [
        "ecs:DescribeServices",
        "ecs:UpdateService"
      ]
      resources = ["*"]
    }
}
