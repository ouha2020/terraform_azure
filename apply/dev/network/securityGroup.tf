
resource "azurerm_network_security_group" "ansgdevops" {
  name                = "ansgdevops"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = local.ports
    content {
      name                       = "port-${security_rule.value.port}"
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet_network_security_group_association" "asnsgadevops" {
  count                     = length([for k, v in azurerm_subnet.azdevops : v.id])
  subnet_id                 = [for k, v in azurerm_subnet.azdevops : v.id][count.index]
  network_security_group_id = azurerm_network_security_group.ansgdevops.id
}
