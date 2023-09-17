variable "project" {
    type = string
    description = "Project name"
}

variable "environment" {
    type = string
    description = "Environment name"
}

variable "cidr_block" {
  type = object({
    vpc = string
    public_subnet_ingress_1a = string
    public_subnet_ingress_1c = string
    private_subnet_application_1a = string
    private_subnet_application_1c = string
    private_subnet_db_1a = string
    private_subnet_db_1c = string
    private_subnet_egress_1a = string
    private_subnet_egress_1c = string
  })
  description = "Series of CIDR Block"
}

variable "vpc_flow_logs_role_arn" {
  type = string
  description = "VPC Flow Logs Role ARN"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
