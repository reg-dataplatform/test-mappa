provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  region = "us-east-1"
  alias = "certification"
}

terraform {
  required_providers {
    archive = "~> 1.3"
    aws     = "~> 3"
    local   = "~> 1.4"
  }
}