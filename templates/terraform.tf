terraform {
  backend "s3" {
    key = "terraform-aws/terraform.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.20.0"
    }

    random = {
      source  = "hashicorp/random"
    }

    local = {
      source  = "hashicorp/local"
    }

    null = {
      source  = "hashicorp/null"
    }

    template = {
      source  = "hashicorp/template"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
    }
  }

  required_version = "> 0.13"


}
