
resource "azurerm_resource_group" "rg_lab_001" {
    name = "rg-lab-001"
    location = var.location
}

resource "azurerm_virtual_network" "vnet_001" {
    name = "vnet-001"
    location = var.location
    resource_group_name = azurerm_resource_group.rg_lab_001.name
    address_space = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "snet_client" {
  name = "snet-client"
  resource_group_name  = azurerm_resource_group.rg_lab_001.name
  virtual_network_name = azurerm_virtual_network.vnet_001.name
  address_prefixes     = ["10.10.10.0/24"]
  default_outbound_access_enabled = false
}

resource "azurerm_subnet" "snet_storage" {
  name = "snet-storage"
  resource_group_name  = azurerm_resource_group.rg_lab_001.name
  virtual_network_name = azurerm_virtual_network.vnet_001.name
  address_prefixes     = ["10.10.20.0/24"]
   default_outbound_access_enabled = false
}