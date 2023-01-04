terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "<bucket name>"
    key    = "tf-state.tfstate"
    region = "us-east-1"
    profile = "<profile name>"
  }
}


