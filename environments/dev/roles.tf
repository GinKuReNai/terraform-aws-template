module "roles" {
    source = "../../modules/roles"
    project = "terraform-aws-sample"
    environment = "dev"
}
