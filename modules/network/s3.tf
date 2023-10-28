# ---------------------------------------
# S3 Bucket for ALB access log
# ---------------------------------------
resource "aws_s3_bucket" "alb_access_log_bucket" {
  bucket = "${var.project}-${var.environment}-alb-access-log-${data.aws_caller_identity.current.account_id}"
}

# ---------------------------------------
# Bucket Ownership
# ---------------------------------------
resource "aws_s3_bucket_ownership_controls" "alb_access_log_ownership" {
  bucket = aws_s3_bucket.alb_access_log_bucket.bucket

  rule {
    # Disable object ACL
    # Ownership of all objects in this bucket becomes the bucket owner
    object_ownership = "BucketOwnerEnforced"
  }
}

# ---------------------------------------
# Denial of Public Access
# ---------------------------------------
resource "aws_s3_bucket_public_access_block" "public_access_block_for_alb_access_log" {
  bucket = aws_s3_bucket.alb_access_log_bucket.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

# ---------------------------------------
# Bucket Policy
# ---------------------------------------
resource "aws_s3_bucket_policy" "alb_access_log_bucket_policy" {
  bucket = aws_s3_bucket.alb_access_log_bucket.id
  policy = data.aws_iam_policy_document.alb_access_log_bucket_policy_document.json
}

# ---------------------------------------
# Bucket Policy Document
# ---------------------------------------
data "aws_iam_policy_document" "alb_access_log_bucket_policy_document" {
  statement {
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [data.aws_elb_service_account.current.arn]
    }
    actions = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.alb_access_log_bucket.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
  }
}

# ---------------------------------------
# Bucket Encryption
# ---------------------------------------
resource "aws_s3_bucket_server_side_encryption_configuration" "alb_access_log_sse_configuration" {
  bucket = aws_s3_bucket.alb_access_log_bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
