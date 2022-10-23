output "vm_ips" {
  value = [for k, v in azurerm_linux_virtual_machine.avmdevops : v.private_ip_address]

}