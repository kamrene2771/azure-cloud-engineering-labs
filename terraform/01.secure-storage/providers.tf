terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "5.0.0"
        }
    }
}

provider "azurerm" {
    features {}

    subscription_id = var.subs_id
    tenant_id = var.ten_id
    client_id = var.client_id
    client_secret = var.client_scrt

}

