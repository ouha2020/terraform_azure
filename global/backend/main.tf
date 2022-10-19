resource "azurerm_resource_group" "argdevops" {
  name     = "devopresources"
  location = "Japan East"
}

resource "azurerm_storage_account" "ascdevops" {
  name                     = "ascdevops"
  resource_group_name      = azurerm_resource_group.argdevops.name
  location                 = azurerm_resource_group.argdevops.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "tfdev"
  }
}

resource "azurerm_storage_container" "ascdevops" {
  name                  = "ascdevops"
  storage_account_name  = azurerm_storage_account.ascdevops.name
  container_access_type = "private"
  depends_on = [
    azurerm_storage_account.ascdevops
  ]
}