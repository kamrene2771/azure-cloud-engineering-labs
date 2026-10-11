
resource "azurerm_resource_group" "rg_lab_001" {
  name     = "rg-lab-001"
  location = var.location
}

resource "azurerm_virtual_network" "vnet_001" {
  name                = "vnet-001"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_lab_001.name
  address_space       = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "snet_client" {
  name                            = "snet-client"
  resource_group_name             = azurerm_resource_group.rg_lab_001.name
  virtual_network_name            = azurerm_virtual_network.vnet_001.name
  address_prefixes                = ["10.10.10.0/24"]
  default_outbound_access_enabled = false
}

resource "azurerm_subnet" "snet_storage" {
  name                            = "snet-storage"
  resource_group_name             = azurerm_resource_group.rg_lab_001.name
  virtual_network_name            = azurerm_virtual_network.vnet_001.name
  address_prefixes                = ["10.10.20.0/24"]
  default_outbound_access_enabled = false
}

resource "azurerm_storage_account" "storage_acc" {
  name                     = "storageaccountlilahk"
  resource_group_name      = azurerm_resource_group.rg_lab_001.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier              = "Cold"
  public_network_access_enabled = false

}

resource "azurerm_private_endpoint" "priv_endpoint" {
  name                = "private-endpoint-001"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_lab_001.name
  subnet_id           = azurerm_subnet.snet_storage.id

  private_service_connection {
    name                           = "lab001-priv-conn"
    private_connection_resource_id = azurerm_storage_account.storage_acc.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "priv-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.priv_dns_z.id]
  }
}

resource "azurerm_private_dns_zone" "priv_dns_z" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.rg_lab_001.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_dnszone_link" {
  name                = "vnet-link"
  private_dns_zone_id = azurerm_private_dns_zone.priv_dns_z.id
  virtual_network_id  = azurerm_virtual_network.vnet_001.id
}

resource "azurerm_storage_container" "blob_001" {
  name                  = "blob-001"
  storage_account_id    = azurerm_storage_account.storage_acc.id
  container_access_type = "private"
}

resource "azurerm_network_interface" "nic_001" {
  name                = "vm-nic-001"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_lab_001.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.snet_client.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm_lab_001" {
  name                = "vm-lab-001"
  resource_group_name = azurerm_resource_group.rg_lab_001.name
  location            = var.location
  size                = "B2ats_v2"
  admin_username      = "azuser"
  network_interface_ids = [
    azurerm_network_interface.nic_001.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}