# ---------------------------------------
# GitHub CodeStar Connection
# ---------------------------------------
resource "aws_codestarconnections_connection" "github" {
  name = "${var.project}-${var.environment}-git"
  provider_type = "GitHub"
}
