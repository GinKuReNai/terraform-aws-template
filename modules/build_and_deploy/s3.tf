# ---------------------------------------
# S3 Bucket for Codepipeline artifact
# ---------------------------------------
resource "aws_s3_bucket" "codepipeline_artifact" {
  bucket = "${var.project}-${var.environment}-codepipeline-artifact-${data.aws_caller_identity.current.account_id}"
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
