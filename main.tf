terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=2.92.0"
        }
    }
}

provider "azurerm" {
    features {}
}

variable "container" {
    nomContainer = "weatherapi"
}

resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "Canada Central"
}

resource "azurerm_container_group" "tfcg_test" {
  name                      = container.nomContainer
  location                  = azurerm_resource_group.tf_test.location
  resource_group_name       = azurerm_resource_group.tf_test.name

  ip_address_type     = "public"
  dns_name_label      = "ottosbigdockweatherapi"
  os_type             = "Linux"

  container {
      name            = "weatherapi"
      image           = "ottosbigdock/weatherapi"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}