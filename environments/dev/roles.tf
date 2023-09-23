module "roles" {
    source = "../../modules/roles"
    project = "aws-tf-sample"
    environment = "dev"
}
