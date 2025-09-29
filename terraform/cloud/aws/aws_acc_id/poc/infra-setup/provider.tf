terraform {
  required_version = ">=1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.9.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.3.7"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.5.0"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.25.0"
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

provider "postgresql" {
  host            = module.aurora_postgres_primary[0].db_host
  port            = module.aurora_postgres_primary[0].db_port
  database        = module.aurora_postgres_primary[0].db_name
  username        = module.aurora_postgres_primary[0].db_user
  password        = module.aurora_postgres_primary[0].db_pass
  sslmode         = "require"
}