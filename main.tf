terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "azure_daas_rg" {
  name = "Azure-Daas-RG"
  location = "northeurope"
}

resource "azurerm_shared_image_gallery" "azure_image_gallery" {
  name = "packerImageGallery"
  resource_group_name = azurerm_resource_group.azure_daas_rg.name
  location = "northeurope"
}

resource "azurerm_shared_image" "windows10_shared_image" {
  name = "windows10-image-azure"
  gallery_name = azurerm_shared_image_gallery.azure_image_gallery.name
  resource_group_name = azurerm_resource_group.azure_daas_rg.name
  location = "northeurope"
  os_type = "Windows"
  hyper_v_generation = "V2"

  identifier {
    publisher = "AIB"
    offer = "Windows-10"
    sku = "windows10-image-azure"
  }
}

resource "azurerm_storage_account" "azure_daas_storage_account" {
  name                     = "azuredaasstorageaccount"
  resource_group_name      = azurerm_resource_group.azure_daas_rg.name
  location                 = "northeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
