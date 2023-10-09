module "application" {
    source = "../../modules/application"
    project = "aws-tf-sample"
    environment = "dev"

    database_name = "sample"
    master_username = "user"
    master_password = "password"

    ecs_sg_id = module.network.ecs_sg_id
    ecs_subnet_1a_id = module.network.ecs_subnet_1a_id
    ecs_subnet_1c_id = module.network.ecs_subnet_1c_id
    db_subnet_group_name = module.network.db_subnet_group_name
    db_security_group_id = module.network.db_security_group_id
    alb_target_group_for_prod_arn = module.network.alb_target_group_for_prod_arn
    alb_target_group_for_test_arn = module.network.alb_target_group_for_test_arn
    ecs_task_role_arn = module.roles.ecs_task_role_arn
    ecs_task_execution_role_arn = module.roles.ecs_task_execution_role_arn
    rds_monitoring_role_arn = module.roles.rds_monitoring_role_arn
}
