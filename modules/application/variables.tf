variable "project" {
    type = string
    description = "Project name"
}

variable "environment" {
    type = string
    description = "Environment name"
}

variable "database_name" {
  type = string
  description = "Database Name"
}

variable "master_username" {
  type = string
  description = "Master Username"
}

variable "master_password" {
  type = string
  description = "Master Password"
}

variable "ecs_sg_arn" {
  type = string
  description = "ARN of IAM role to be assigned to ECS"
}

variable "ecs_subnet_1a_id" {
  type = string
  description = "Subnet ARN(1a)"
}

variable "ecs_subnet_1c_id" {
  type = string
  description = "Subnet ARN(1c)"
}

variable "db_subnet_group_name" {
  type = string
  description = "Database Subnet Group Name"
}

variable "db_security_group_id" {
  type = string
  description = "Database Security Group ID"
}

variable "alb_target_group_for_blue_arn" {
  type = string
  description = "ARN of the target group of ALB (Blue)"
}

variable "alb_target_group_for_green_arn" {
  type = string
  description = "arn of the target group of alb (Green)"
}

variable "ecs_task_role_arn" {
  type = string
  description = "ECS Task Role ARN"
}

variable "ecs_task_execution_role_arn" {
  type = string
  description = "ECS Task Execution Role ARN"
}

variable "rds_monitoring_role_arn" {
  type = string
  description = "RDS Monitoring Role ARN"
}
