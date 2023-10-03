# ---------------------------------------
# CloudWatch Log Group(CodePipeline)
# ---------------------------------------
resource "aws_cloudwatch_log_group" "codepipeline_log_group" {
  name = "${var.project}-${var.environment}-codepipeline-log-group"
}
