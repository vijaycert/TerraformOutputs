resource "azurerm_resource_group" "tf_az_rg" {
  name     = var.vRg_name
  location = var.vAzureLoc
}

resource "azurerm_virtual_network" "tf_az_vnet" {
  name                = var.vVnet_name
  address_space       = var.vVnet_address_space
  location            = var.vAzureLoc
  resource_group_name = var.vRg_name
  depends_on          = [azurerm_resource_group.tf_az_rg]
}

resource "azurerm_subnet" "tf_az_lin_subnet" {
  name                 = var.vSubnet_Lin_name
  resource_group_name  = var.vRg_name
  virtual_network_name = azurerm_virtual_network.tf_az_vnet.name
  address_prefixes     = var.vSubnet_Lin_space

  depends_on = [azurerm_virtual_network.tf_az_vnet]
}

resource "azurerm_public_ip" "lin_pip" {
  name                = var.lin_public_ip
  location            = var.vAzureLoc
  resource_group_name = var.vRg_name
  allocation_method   = "Dynamic"

  tags = {
    environment = "Development"
  }
  depends_on = [azurerm_resource_group.tf_az_rg]
}

resource "azurerm_network_interface" "tf_az_lin_nic" {
  name                = var.vNic_lin_name
  location            = var.vAzureLoc
  resource_group_name = var.vRg_name

  ip_configuration {
    name                          = "ipconfig_Lin"
    subnet_id                     = azurerm_subnet.tf_az_lin_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.lin_pip.id
  }
  depends_on = [azurerm_resource_group.tf_az_rg]
}

resource "azurerm_linux_virtual_machine" "tf_az_linux_vm" {
  name                            = var.vLinux_VM_name
  location                        = var.vAzureLoc
  resource_group_name             = var.vRg_name
  size                            = var.vLinux_VM_size
  admin_username                  = "adminuser"
  admin_password                  = "admin123!"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.tf_az_lin_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

resource "azurerm_subnet" "tf_az_win_subnet" {
  name                 = var.vSubnet_Win_name
  resource_group_name  = var.vRg_name
  virtual_network_name = azurerm_virtual_network.tf_az_vnet.name
  address_prefixes     = var.vSubnet_Win_space

  depends_on = [azurerm_virtual_network.tf_az_vnet]
}

resource "azurerm_public_ip" "win_pip" {
  name                = var.win_public_ip
  location            = var.vAzureLoc
  resource_group_name = var.vRg_name
  allocation_method   = "Dynamic"

  tags = {
    environment = "Development"
  }
  depends_on = [azurerm_resource_group.tf_az_rg]
}

resource "azurerm_network_interface" "tf_az_win_nic" {
  name                = var.vNic_win_name
  location            = var.vAzureLoc
  resource_group_name = var.vRg_name

  ip_configuration {
    name                          = "ipconfig_Win"
    subnet_id                     = azurerm_subnet.tf_az_win_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.win_pip.id
  }
  depends_on = [azurerm_resource_group.tf_az_rg]
}

resource "azurerm_windows_virtual_machine" "tf_az_windows_vm" {
  name                = var.vWin_VM_name
  location            = var.vAzureLoc
  resource_group_name = var.vRg_name
  size                = "Standard_DS1_V2"
  admin_username      = "adminuser"
  admin_password      = "admin123!"
  network_interface_ids = [
    azurerm_network_interface.tf_az_win_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "microsoftwindowsdesktop"
    offer     = "windows-10"
    sku       = "win10-21h2-pro"
    version   = "latest"
  }
}