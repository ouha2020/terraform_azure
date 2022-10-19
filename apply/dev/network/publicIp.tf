resource "azurerm_public_ip" "apidevops" {
  for_each            = toset(local.vms)
  name                = local.vms_config[each.value]["publicIpName"]
  location            = var.location
  resource_group_name = var.resource_group_name
  zones = ["1","2","3"]
  sku = "Standard"
  allocation_method = "Static"

  tags = {
    environment = "apidevops"
  }
}
