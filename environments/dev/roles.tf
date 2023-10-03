module "roles" {
    source = "../../modules/roles"
    project = "aws-tf-sample"
    environment = "dev"
    ecr_arn = module.application.ecr_arn
    ecr_repository_name = module.application.ecr_repository_name
    codebuild_arn = module.build_and_deploy.arn
    codepipeline_log_group_arn = module.build_and_deploy.codepipeline_log_group.arn
    codepipeline_artifact_bucket_arn = module.build_and_deploy.codepipeline_artifact_bucket.arn
}
