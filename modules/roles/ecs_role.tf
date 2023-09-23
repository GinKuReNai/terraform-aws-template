# ---------------------------------------
# Assume Role(Task Role)
# ---------------------------------------
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.project}-${var.environment}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_role_document.json
}

# ---------------------------------------
# Assume Role Policy Document(Task Role)
# ---------------------------------------
data "aws_iam_policy_document" "ecs_task_role_document" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [ "ecs-tasks.amazonaws.com" ]
    }
    actions = ["sts:AssumeRole"]
  }
}

# ---------------------------------------
# IAM Policy(Task Role)
# ---------------------------------------
resource "aws_iam_role_policy" "ecs_task_policy" {
  name = "${var.project}-${var.environment}-ecs-task-role-policy"
  role = aws_iam_role.ecs_task_role.name
  policy = data.aws_iam_policy_document.ecs_task_role_policy_document.json
}

# ---------------------------------------
# IAM Policy Document(Task Role)
# ---------------------------------------
data "aws_iam_policy_document" "ecs_task_role_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = ["*"]
  }
}

#########################################

# ---------------------------------------
# Assume Role(Task Execution Role)
# ---------------------------------------
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project}-${var.environment}-ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role_document.json
}

# ---------------------------------------
# Assume Role Policy Document(Task Execution Role)
# ---------------------------------------
data "aws_iam_policy_document" "ecs_task_execution_role_document" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [ "ecs-tasks.amazonaws.com" ]
    }
    actions = ["sts:AssumeRole"]
  }
}

# ---------------------------------------
# IAM Policy(Task Execution Role)
# ---------------------------------------
resource "aws_iam_role_policy" "ecs_task_execution_policy" {
  name = "${var.project}-${var.environment}-ecs-task-execution-role-policy"
  role = aws_iam_role.ecs_task_execution_role.name
  policy = data.aws_iam_policy_document.ecs_task_execution_role_policy_document.json
}

# ---------------------------------------
# IAM Policy Document(Task Execution Role)
# ---------------------------------------
data "aws_iam_policy_document" "ecs_task_execution_role_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndPoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:UpdateContainerInstancesState",
      "ecs:Submit*",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}
