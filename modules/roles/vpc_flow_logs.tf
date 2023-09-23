# ---------------------------------------
# Assume Role
# ---------------------------------------
resource "aws_iam_role" "vpc_flow_logs_role" {
  name = "${var.project}-${var.environment}-vpc-flow-logs-role"
  assume_role_policy = data.aws_iam_policy_document.vpc_flow_logs_role_document.json
}

# ---------------------------------------
# Assume Role Policy Document
# ---------------------------------------
data "aws_iam_policy_document" "vpc_flow_logs_role_document" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# ---------------------------------------
# IAM Policy
# ---------------------------------------
resource "aws_iam_role_policy" "vpc_flow_logs_role_policy" {
  name = "${var.project}-${var.environment}-vpc-flow-logs-role-policy"
  role = aws_iam_role.vpc_flow_logs_role.name
  policy = data.aws_iam_policy_document.vpc_flow_logs_role_policy_document.json
}

# ---------------------------------------
# IAM Policy Document
# ---------------------------------------
data "aws_iam_policy_document" "vpc_flow_logs_role_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = ["*"]
  }
}
