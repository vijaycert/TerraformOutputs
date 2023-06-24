output "tf_az_windows_public_ip" {
  description = "Public ID of Windows VM"
  value       = azurerm_public_ip.lin_pip.ip_address
}

output "tf_az_linux_public_ip" {
  description = "Public ID of Linux VM"
  value       = azurerm_public_ip.win_pip.ip_address
}

output "tf_az_windows_pvt_ip" {
  description = "Private ID of Windows VM"
  value       = azurerm_network_interface.tf_az_win_nic.private_ip_address
}

output "tf_az_linux_pvt_ip" {
  description = "Private ID of Linux VM"
  value       = azurerm_network_interface.tf_az_lin_nic.private_ip_address
}

output "tf_az_windows_vmid" {
  description = "ID of Windows VM"
  value       = azurerm_windows_virtual_machine.tf_az_windows_vm.id
}

output "tf_az_linux_vmid" {
  description = "ID of Linux VM"
  value       = azurerm_linux_virtual_machine.tf_az_linux_vm.id
}
