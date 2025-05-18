terraform {
  required_version = ">=1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.88.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.29.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.13.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.1"
    }
  }

  backend "s3" {
    use_lockfile   = true
    encrypt        = true
    key            = "k8saddons/k8saddons.tfstate"
  }
}

# Calling infra-setup terraform state to fetch data
data "terraform_remote_state" "infra_setup_tf" {
  backend = "s3"
  config = {
    key            = "infrasetup/infrasetup.tfstate"
    use_lockfile   = true
    region         = var.region
    bucket         = var.bucket
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = local.tags
  }
}

# Deploying into the existing EKS
provider "kubernetes" {
  config_path    = var.local_kube_config
  # config_context = "context"
}

provider "helm" {
  kubernetes {
    config_path    = var.local_kube_config
    # config_context = "context"
  }
  burst_limit = 3600
  debug       = true
  # experiments {
  #   manifest = true
  # }
}