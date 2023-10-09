# ---------------------------------------
# CodeDeploy
# ---------------------------------------
resource "aws_codedeploy_app" "deploy" {
  compute_platform = "ECS"
  name = "${var.project}-${var.environment}-codedeploy"
}

# ---------------------------------------
# CodeDeploy Deployment Config
# ---------------------------------------
resource "aws_codedeploy_deployment_config" "deployment_config" {
  deployment_config_name = "${var.project}-${var.environment}-deployment-config"
  compute_platform = "ECS"

  # Define how many instances should be normal (healthy) when deployed
  minimum_healthy_hosts {
    # Specify the number of ECS tasks
    type = "INSTANCE_COUNT"
    value = 1
  }
}

# ---------------------------------------
# CodeDeploy Deployment Group
# ---------------------------------------
resource "aws_codedeploy_deployment_group" "deployment_group" {
  app_name = aws_codedeploy_app.deploy.name
  deployment_group_name = "${var.project}-${var.environment}-deploy-group"
  service_role_arn = var.codedeploy_role_arn
  deployment_config_name = aws_codedeploy_deployment_config.deployment_config.id
  
  # Automatic rollback to a previous version if it fails for any reason
  auto_rollback_configuration {
    enabled = true
    # List of events that trigger automatic rollback
    # DEPLOYMENT_FAULURE : Rollback if deployment fails
    # DEPLOYMENT_STOP_ON_ALERM : Rollback when deployments are stopped by CloudWatch alarms
    events = [ "DEPLOYMENT_FAILURE" ]
  }

  # Advanced Settings for Bluegreen Deployment
  blue_green_deployment_config {
    deployment_ready_option {
      # Specifies the action to be taken if the deployment preparation times out
      # CONTINUE_DEPLOYMENT : CodeDeploy continues deployment after the deployment preparation phase times out
      # For example, if a particular health check or application startup verification times out, the deployment process will continue to the next step
      # STOP_DEPLOYMENT : Deployment is stopped when a timeout occurs during the deployment preparation phase
      action_on_timeout = "STOP_DEPLOYMENT"
      wait_time_in_minutes = 30
    }

    terminate_blue_instances_on_deployment_success {
      # Specify how to terminate existing (Blue) fleet instances after successful deployment
      # TERMINATE : Instances are terminated after a specified wait time
      # KEEP_ALIVE : Instances are left running after they are deregistered from the load balancer and removed from the deployment group
      action = "TERMINATE"
      termination_wait_time_in_minutes = 15
    }
  }

  deployment_style {
    # For ECS deployment, the deployment type must be BLUE_GREEN, and deployment option must be WITH_TRAFFIC_CONTROL
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = var.ecs_cluster_name
    service_name = var.ecs_service_name
  }

  load_balancer_info {
    # To support Blue/Green deployment of ECS services, specifying information on two target groups (Blue and Green)
    target_group_pair_info {
      # Specifies the ARN of the listener action for routing production traffic
      prod_traffic_route {
        listener_arns = [var.prod_alb_listener_arn]
      }

      # Specify ALB listener action information for routing test traffic
      test_traffic_route {
        listener_arns = [var.test_alb_listener_arn]
      }

      target_group {
        name = var.prod_alb_target_group_name
      }

      target_group {
        name = var.test_alb_target_group_name
      }
    }
  }
}
