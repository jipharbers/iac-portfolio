terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = { source = "hashicorp/azurerm" }
    local   = { source = "hashicorp/local" }
  }
}

provider "azurerm" { features {} }

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name}-vnet"
  address_space       = ["10.42.0.0/16"]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.name}-subnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.42.1.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.name}-nsg"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  security_rule {
    name                       = "allow_ssh_in"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "pip" {
  for_each            = toset(["vm1","vm2"])
  name                = "${var.name}-${each.key}-pip"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "nic" {
  for_each            = azurerm_public_ip.pip
  name                = "${var.name}-${each.key}-nic"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "ipcfg"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[each.key].id
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  for_each                  = azurerm_network_interface.nic
  network_interface_id      = each.value.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

locals {
  cloud_init = file("${path.module}/cloud-init/cloud-config.yaml")
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = azurerm_network_interface.nic
  name                = "${var.name}-${each.key}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  size                = "Standard_B1s"

  admin_username = "chipuser"
  disable_password_authentication = true

  network_interface_ids = [ each.value.id ]

  os_disk {
    name                 = "${var.name}-${each.key}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "chipuser"
    public_key = file(var.ssh_public_key_path)
  }

  # Azure verwacht Base64 voor custom_data
  custom_data = base64encode(local.cloud_init)
}

output "azure_public_ips" {
  value = { for k, v in azurerm_public_ip.pip : k => v.ip_address }
}

resource "local_file" "azure_ips_txt" {
  filename = "${path.module}/AZURE_IPS.txt"
  content  = join("\n", values({ for k, v in azurerm_public_ip.pip : k => v.ip_address }))
}
