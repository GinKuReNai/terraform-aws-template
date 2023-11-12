# ---------------------------------------
# Autoscaling
# ---------------------------------------
resource "aws_appautoscaling_target" "autoscaling_ecs_target" {
  service_namespace = "ecs"

  # Specify the ECS service to be scaled
  resource_id = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.ecs_service.name}"

  # Define specific attributes that will be the basis for scale-out or scale-in
  # ecs:service:DesiredCount : Increase or decrease the number of tasks to cope with the service load
  # ec2:spot-fleet-request:TargetCapacity : Increase or decrease the number of EC2 Spot Instances in the fleet
  # rds:cluster:ReadReplicaCount : Increase or decrease the number of Aurora Replicas in the cluster
  # dynamodb:table:ReadCapacityUnits : Increase or decrease the number of read capacity units for a DynamoDB table
  scalable_dimension = "ecs:service:DesiredCount"

  role_arn = var.autoscaling_role_arn

  # Specify the minimum and maximum number of tasks
  min_capacity = 1
  max_capacity = 5
}

# ---------------------------------------
# Autoscaling Policy (Target Tracking Scaling By CPU Utilization)
# ---------------------------------------
resource "aws_appautoscaling_policy" "ecs_cpu_target_tracking_scaling" {
  name = "${var.project}-${var.environment}-ecs-cpu-target-tracking-scaling"
  service_namespace = aws_appautoscaling_target.autoscaling_ecs_target.service_namespace
  resource_id = aws_appautoscaling_target.autoscaling_ecs_target.resource_id

  scalable_dimension = aws_appautoscaling_target.autoscaling_ecs_target.scalable_dimension
  policy_type = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    target_value = 70
    scale_out_cooldown = 120
    scale_in_cooldown = 120
    disable_scale_in = false

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

# ---------------------------------------
# Autoscaling Policy (Target Tracking Scaling By Memory Utilization)
# ---------------------------------------
resource "aws_appautoscaling_policy" "ecs_memory_target_tracking_scaling" {
  name = "${var.project}-${var.environment}-ecs-memory-target-tracking-scaling"
  service_namespace = aws_appautoscaling_target.autoscaling_ecs_target.service_namespace
  resource_id = aws_appautoscaling_target.autoscaling_ecs_target.resource_id

  scalable_dimension = aws_appautoscaling_target.autoscaling_ecs_target.scalable_dimension
  policy_type = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    target_value = 70
    scale_out_cooldown = 120
    scale_in_cooldown = 120
    disable_scale_in = false

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}
