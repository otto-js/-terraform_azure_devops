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

resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "Canada Central"
}

resource "azurerm_container_group" "tfcg_test" {
  name                      = "weatherapi"
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
}lgupv47ihzwt6nusvs5p3v5uxaqexuzb2v6vcf2brn6ludqhicia