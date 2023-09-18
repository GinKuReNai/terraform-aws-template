# ---------------------------------------
# Secrets Manager
# ---------------------------------------
resource "aws_secretsmanager_secret" "rds_secrets" {
  name = "${var.project}-${var.environment}-rds-secrets"
}

# For security reasons, the actual values should be set on the console
resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = aws_secretsmanager_secret.rds_secrets.id
  secret_string = jsonencode({
    database_name = "",
    master_username = "",
    master_password = ""
  })
}

# Convert as a map for reference
locals {
  rds_secrets = jsondecode(aws_secretsmanager_secret_version.rds_secret_version.secret_string)
}
