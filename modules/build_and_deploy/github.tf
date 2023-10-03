# ---------------------------------------
# GitHub CodeStar Connection
# ---------------------------------------
resource "aws_codestarconnections_connection" "github" {
  name = "${var.project}-${var.environment}-github-connection"
  provider_type = "GitHub"
}
