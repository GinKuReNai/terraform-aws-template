# ---------------------------------------
# CloudWatch Log Group(VPC Flow Logs)
# ---------------------------------------
resource "aws_cloudwatch_log_group" "vpc_flow_logs_log_group" {
  name = "${var.project}-${var.environment}-vpc-flow-logs-log-group"
}
