resource "azurerm_linux_virtual_machine" "avmdevops" {
  for_each                        = toset(local.vms)
  name                            = "avmdevops-${each.value}"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  admin_password                  = "Password321#"
  disable_password_authentication = false
  network_interface_ids = [
    local.vms_config[each.value]["nicids"],
  ]
  user_data = base64encode(file("${path.module}/config/installapp.sh"))

  os_disk {
    name                 = "disk-${each.value}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
