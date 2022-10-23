output "subnetids" {
  value = [for k, v in azurerm_subnet.azdevops : v.id]
}

output "vmpublicip" {
  value = [for k, v in azurerm_public_ip.apidevops : v.id]
}

output "vnetid" {
  value = azurerm_virtual_network.avndevops.id
}

output "lbpublicip" {
  value = azurerm_public_ip.apilbdevops.id
}

output "nicids" {
  value = azurerm_network_interface.anidevops.*.id
}
