terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 2.2.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.4.0"
    }

    # TLS provider to help generate SSH keys

    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.4.0"
    }
  }
}