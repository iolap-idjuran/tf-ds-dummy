provider "aws" {
  profile = var.aws_profile_name
}

module "open_network" {
  source = "./modules/open_network"
}

module "public_ec2_istance" {
  source = "./modules/public_ec2_instance"
}