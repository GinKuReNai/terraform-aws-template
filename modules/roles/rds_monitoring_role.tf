# ---------------------------------------
# Assume Role
# ---------------------------------------
resource "aws_iam_role" "rds_monitoring_role" {
  name = "${var.project}-${var.environment}-rds-monitoring-role"
  assume_role_policy = data.aws_iam_policy_document.rds_monitoring_role_policy_document.json
}

# ---------------------------------------
# Assume Role Policy Document
# ---------------------------------------
data "aws_iam_policy_document" "rds_monitoring_role_policy_document" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# ---------------------------------------
# IAM Policy Attachment
# ---------------------------------------
resource "aws_iam_role_policy_attachment" "rds_monitoring_policy_attachment" {
  role = aws_iam_role.rds_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
