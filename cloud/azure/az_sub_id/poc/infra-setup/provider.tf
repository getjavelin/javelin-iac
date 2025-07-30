terraform {
  required_version = ">=1.10"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.33.0"
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
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.25.0"
    }
  }

  backend "azurerm" {
    container_name        = "terraform-state"
    key                   = "infrasetup/infrasetup.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id         = var.az_subscription_id
}

provider "postgresql" {
  host                    = module.postgres_primary[0].postgres_private_ip
  port                    = module.postgres_primary[0].postgres_port
  database                = module.postgres_primary[0].postgres_db_name
  username                = module.postgres_primary[0].postgres_db_user
  password                = module.postgres_primary[0].postgres_db_pass
  sslmode                 = "disable"
}