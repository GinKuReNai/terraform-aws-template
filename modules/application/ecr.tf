# ---------------------------------------
# Elastic Container Registry(ECR)
# ---------------------------------------
resource "aws_ecr_repository" "ecr" {
  name = "${var.project}-${var.environment}-ecr"
  image_tag_mutability = "MUTABLE"
  tags = {
    Name = "${var.project}-${var.environment}-ecr"
  }
}

# ---------------------------------------
# ECR Lifecycle Policy
# ---------------------------------------
resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  repository = aws_ecr_repository.ecr.name
  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description = "Retain only 5 images with 'latest' tag"
      selection = {
        tagStatus = "tagged"
        tagPrefixList = ["latest"]
        countType = "imageCountMoreThan"
        countNumber = 5
      }
      action = {
        type = "expire"
      }
    }]
  })
}
