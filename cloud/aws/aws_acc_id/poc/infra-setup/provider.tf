terraform {
  required_version = ">=1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.88.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.11.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.3.4"
    }
    http = {
      source  = "terraform-aws-modules/http"
      version = "2.4.1"
    }
  }

# Comment this out when initialising the backend_resources first time.
# terraform init
# terraform apply
# uncomment the s3 backend
# terraform init -backend-config="backend.tfvars" -- It will ask you to push the statefile from local to s3
  backend "s3" {
    use_lockfile   = true
    encrypt        = true
    key            = "infrasetup/infrasetup.tfstate"
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = local.tags
  }
}