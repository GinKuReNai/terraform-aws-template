module "roles" {
    source = "../../modules/roles"
    project = "aws-tf-sample"
    environment = "dev"

    ecr_arn = module.application.ecr_arn
    ecr_repository_name = module.application.ecr_repository_name

    codebuild_arn = module.build_and_deploy.codebuild_arn

    codedeploy_arn = module.build_and_deploy.codedeploy_arn
    codedeploy_app_name = module.build_and_deploy.codedeploy_app_name
    codedeploy_deployment_config_name = module.build_and_deploy.codedeploy_deployment_config_name
    codedeploy_deployment_group_name = module.build_and_deploy.codedeploy_deployment_group_name

    codepipeline_log_group_arn = module.build_and_deploy.codepipeline_log_group_arn
    codepipeline_artifact_bucket_arn = module.build_and_deploy.codepipeline_artifact_bucket_arn
}
