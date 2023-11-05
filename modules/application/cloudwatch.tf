# ---------------------------------------
# CloudWatch Log Group (ECS Task)
# ---------------------------------------
resource "aws_cloudwatch_log_group" "ecs_task_log_group" {
  name = "${var.project}-${var.environment}-ecs-task"
}
