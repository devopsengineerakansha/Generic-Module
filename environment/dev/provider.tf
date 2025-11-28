terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.50.0"
    }
  }
  backend "azurerm" {
    resource_group_name   = "rg-akshay"
    storage_account_name  = "tfstateakansha01"
    container_name        = "devtfstate"
    key                   = "terraform.tfstate"
  }
}


provider "azurerm" {
  features {}
  subscription_id = "a5aaa5ad-6e93-46b9-a1d8-b3f7d19bf107"
}