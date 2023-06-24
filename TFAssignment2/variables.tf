variable "vAzureLoc" {
  type = string
}

variable "vRg_name" {
  type = string
}

variable "vVnet_name" {
  type = string
}

variable "vVnet_address_space" {
  type = list(string)
}

variable "vSubnet_Lin_name" {
  type = string
}

variable "vSubnet_Lin_space" {
  type = list(string)
}

variable "vSubnet_Win_name" {
  type = string
}

variable "vSubnet_Win_space" {
  type = list(string)
}

variable "vLinux_VM_name" {
  type = string
}

variable "vWin_VM_name" {
  type = string
}

variable "vLinux_VM_size" {
  type = string
}

variable "vWin_VM_size" {
  type = string
}

variable "vLinux_OS_disk_size" {
  type = number
}

variable "vWin_OS_disk_size" {
  type = number
}

variable "vNic_lin_name" {
  type = string
}

variable "vNic_win_name" {
  type = string
}

variable "lin_public_ip" {
  type = string
}

variable "win_public_ip" {
  type = string
}