terraform {
  required_providers {
    azurerm = {
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
data "azurerm_subscription" "current" {
}

resource "azurerm_management_group" "root" {
  display_name = "broccolifamily.net"
}

resource "azurerm_management_group" "Level1" {
  display_name               = "Level1Group"
  parent_management_group_id = azurerm_management_group.root.id
#  subscription_ids = [
#    data.azurerm_subscription.current.subscription_id,
#  ]
   subscription_ids = ["8de647e8-3e51-4089-9df2-08ad6d25c973",]
}
