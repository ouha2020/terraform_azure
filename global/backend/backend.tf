terraform {
  backend "azurerm" {
    resource_group_name  = "devopresources"
    storage_account_name = "ascdevops"
    container_name       = "ascdevops"
    key                  = "global/backend/terraform-backend.tfstate"
  }
}