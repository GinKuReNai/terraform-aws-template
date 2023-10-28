module "roles" {
    source = "../../modules/roles"
    project = "aws-tf-sample"
    environment = "dev"

    ecs_cluster_name = module.application.ecs_cluster_name
    ecs_service_name = module.application.ecs_service_name

    ecr_arn = module.application.ecr_arn
    ecr_repository_name = module.application.ecr_repository_name

    codebuild_arn = module.build_and_deploy.codebuild_arn
    codedeploy_arn = module.build_and_deploy.codedeploy_arn
    codepipeline_log_group_arn = module.build_and_deploy.codepipeline_log_group_arn
    codepipeline_artifact_bucket_arn = module.build_and_deploy.codepipeline_artifact_bucket_arn
}
