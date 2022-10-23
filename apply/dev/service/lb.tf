resource "azurerm_lb" "aldevops" {
  name                = "aldevops"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = local.lbpublicip
  }
}

resource "azurerm_lb_backend_address_pool" "albadevops" {
  loadbalancer_id = azurerm_lb.aldevops.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_backend_address_pool_address" "albapdevops" {
  count                   = length([for k, v in azurerm_linux_virtual_machine.avmdevops : v.private_ip_address])
  name                    = "devops-${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.albadevops.id
  virtual_network_id      = local.vnetid
  ip_address              = [for k, v in azurerm_linux_virtual_machine.avmdevops : v.private_ip_address][count.index]
}

resource "azurerm_lb_rule" "alndevops" {
  loadbalancer_id                = azurerm_lb.aldevops.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.albadevops.id]
}
