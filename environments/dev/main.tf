# ---------------------------------------
# Terraform Configuration
# ---------------------------------------
terraform {
  required_version = ">=1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">5.32.0"
    }
  }

  # Store tfstate in Amazon S3
  # backend "s3" {
  #   bucket = "terraform-tfstate-sample-dev"
  #   key    = "ap-northeast-1/terraform.tfstate"
  #   region = "ap-northeast-1"
  # }
}
