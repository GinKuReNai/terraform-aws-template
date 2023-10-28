module "network" {
    source = "../../modules/network"
    project = "aws-tf-sample"
    environment = "production"

    cidr_block = {
        vpc = "10.0.0.0/16"
        public_subnet_ingress_1a = "10.0.0.0/24"
        public_subnet_ingress_1c = "10.0.1.0/24"
        private_subnet_application_1a = "10.0.8.0/24"
        private_subnet_application_1c = "10.0.9.0/24"
        private_subnet_db_1a = "10.0.16.0/24"
        private_subnet_db_1c = "10.0.17.0/24"
        private_subnet_egress_1a = "10.0.248.0/24"
        private_subnet_egress_1c = "10.0.249.0/24"
    }

    vpc_flow_logs_role_arn = module.roles.vpc_flow_logs_role_arn
}
