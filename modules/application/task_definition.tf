# ---------------------------------------
# ECS Task Definition
# ---------------------------------------
resource "aws_ecs_task_definition" "task_definition" {
  family = "${var.project}-${var.environment}-task"
  # Specify activation type; select FARGATE
  requires_compatibilities = ["FARGATE"]
  # If FARGATE is selected, always select awsvpc
  network_mode = "awsvpc"
  # If FARGATE is selected, always set cpu and memory resources explicitly
  cpu = 256 # (1vCPU = 1024)
  memory = 512 # (MiB)

  # IAM roles required when the ECS Container Agent executes (starts) a task
  execution_role_arn = var.ecs_task_execution_role_arn
  # IAM roles used when using AWS services from applications in containers
  task_role_arn = var.ecs_task_role_arn

  tags = {
    Name = "${var.project}-${var.environment}-task"
  }

  container_definitions = jsonencode([
    {
      name = "${aws_ecs_cluster.ecs_cluster.name}-app"
      image = "${aws_ecr_repository.ecr.repository_url}:latest"
      essential = true
      portMappings = [{
        protocol = "tcp"
        containerPort = 8000
        hostPort = 8000
      }]
    }
  ])
}
