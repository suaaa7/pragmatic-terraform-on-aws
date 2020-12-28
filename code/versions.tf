terraform {
  required_version = ">= 0.12.0"
  required_providers {
    aws    = ">= 3.21.0"
    github = ">= 4.1.0"
    random = ">= 3.0.0"
  }
}

provider "aws" {
  region = var.region
}

provider "github" {
  owner = var.github_owner
}

provider "random" {}
