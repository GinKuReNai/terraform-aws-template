# ---------------------------------------
# ECS Cluster
# ---------------------------------------
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.project}-${var.environment}-ecs-cluster"
  tags = {
    Name = "${var.project}-${var.environment}-ecs-cluster"
  }
}

# ---------------------------------------
# ECS Service
# ---------------------------------------
resource "aws_ecs_service" "ecs_service" {
  name = "${var.project}-${var.environment}-ecs-service"
  cluster = aws_ecs_cluster.ecs_cluster.arn
  task_definition = aws_ecs_task_definition.task_definition.arn
  # Number of tasks maintained by ECS
  desired_count = 2
  launch_type = "FARGATE"
  platform_version = "LATEST"
  # Grace period for health check at task startup (seconds)
  health_check_grace_period_seconds = 60
  # Enables interactive command execution for containers in the ECS
  enable_execute_command = true

  # Automatically stops deployment and rolls back to the original task definition when deployment of a new task for a service fails
  deployment_circuit_breaker {
    enable = true
    rollback = true
  }

  network_configuration {
    # No need to assign a public IP since it is in a private subnet
    assign_public_ip = false
    security_groups = [ var.ecs_sg_arn ]
    subnets = [
      var.ecs_subnet_1a_id,
      var.ecs_subnet_1c_id
    ]
  }

  load_balancer {
    target_group_arn = var.alb_target_group_for_blue_arn
    container_name = "app"
    container_port = 8000
  }

  lifecycle {
    ignore_changes = [ task_definition, load_balancer ]
  }

  # Deploy ECS using CodeDeploy's Blue/Green deployment
  deployment_controller {
    type = "CODE_DEPLOY"
  }
}
