module "build_and_deploy" {
    source = "../../modules/build_and_deploy"
    project = "aws-tf-sample"
    environment = "dev"

    github_account_name = var.github_account_name
    github_repository_name = var.github_repository_name
    github_repository_url = var.github_repository_url
    github_repository_branch = var.github_repository_branch

    ecr_repository_name = module.application.ecr_repository_name
    ecs_cluster_name = module.application.ecs_cluster_name
    ecs_service_name = module.application.ecs_service_name

    prod_alb_listener_arn = module.network.alb_listener_for_prod_arn
    test_alb_listener_arn = module.network.alb_listener_for_test_arn
    prod_alb_target_group_name = module.network.alb_target_group_for_prod_name
    test_alb_target_group_name = module.network.alb_target_group_for_test_name

    codebuild_role_arn = module.roles.codebuild_role_arn
    codedeploy_role_arn = module.roles.codedeploy_role_arn
    codepipeline_role_arn = module.roles.codepipeline_role_arn
}
