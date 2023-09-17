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

variable "alb_target_group_for_blue_arn" {
  type = string
  description = "ARN of the target group of ALB (Blue)"
}

variable "alb_target_group_for_green_arn" {
  type = string
  description = "arn of the target group of alb (Green)"
}
