provider "aws" {
  region = "eu-west-1"
}

terraform {
  required_providers {
    archive = "~> 1.3"
    aws     = "~> 3"
    local   = "~> 1.4"
  }
}