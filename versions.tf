terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.39.0"
    }

    time = {
      source  = "hashicorp/time"
      version = ">= 0.4.0"
    }
  }
}
