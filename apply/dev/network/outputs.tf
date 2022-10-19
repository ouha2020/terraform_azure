output "subnetids" {
  value = [for k, v in azurerm_subnet.azdevops : v.id]
}

output "vmpublicip" {
  value = [for k, v in azurerm_public_ip.apidevops : v.id]
}
