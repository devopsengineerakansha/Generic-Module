rgs = {
  rg1 = {
    name       = "rg-akansha"
    location   = "eastus"
    managed_by = "terraform"
    tags = {
      env = "dev"
    }
  }
  rg2 = {
    name       = "rg-kundan"
    location   = "eastus"
    managed_by = "terraform"
    tags = {
      env = "dev"
    }
  }
}

networks = {
  vnet1 = {
    name                = "vnet-dev-app-01"
    location            = "eastus"
    resource_group_name = "rg-akansha"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["10.0.0.4", "10.0.0.5"]
    tags = {
      environment = "Development"
    }

    subnet = {
      s1 = {
        name             = "frontend-subnet"
        address_prefixes = ["10.0.1.0/24"]
      }
      s2 = {
        name             = "backend-subnet"
        address_prefixes = ["10.0.2.0/24"]
      }
    }
  }

  vnet2 = {
    name                = "vnet-prod-app-01"
    location            = "centralindia"
    resource_group_name = "rg-akansha"
    address_space       = ["10.1.0.0/16"]
    tags = {
      environment = "Production"
    }
  }
}

 
administrator_login_password = "P@ssw0rd1234!"

vms = {
  vm1 = {
  nic_name            = "frontend-vm-nic"
  location            = "centralindia"
  resource_group_name = "rg-akansha"
  vm_name             = "frontend-vm"
  size                = "Standard_B1s"
   }

     vm2 = {
  nic_name            = "backend-vm-nic"
  location            = "centralindia"
  resource_group_name = "rg-akansha"
  vm_name             = "backend-vm"
  size                = "Standard_B1s"
   }
  }


container_registries = {
    c1 = {
       name                = "acrdevakansha"
       resource_group_name = "rg-akansha"
       location            = "eastus"
       sku                 = "Standard"
       admin_enabled       = true
    }

}
 
key_vaults = {
  kv1 = {
    name                = "akansha-dev-01"
    location            = "centralindia"
    resource_group_name = "rg-akansha"

    enabled_for_disk_encryption = false
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"

  }
}

key_vault_secret = {

    admin_username = {
    name          = "admin-username"
    value         = "Akansha!"
    key_vault_key = "kv1"       # <-- must match key in key_vaults
  }

  admin_password = {
    name          = "admin-password"
    value         = "MyPassword123!"
    key_vault_key = "kv1"       # <-- must match key in key_vaults
  }

  api_key = {
    name          = "api-key"
    value         = "XYZ-987654"
    key_vault_key = "kv1"       # <-- same KV
  }
}


kubernetes_clusters = {
  c1 = {
    name                = "aks-prod"
    location            = "centralus"
    resource_group_name = "rg-akansha"
    dns_prefix          = "aksprod"
    default_node_pool = {
      name       = "default"
      node_count = 1
      vm_size    = "Standard_B2s"
    }
    identity_type = "SystemAssigned"
    tags = {
      Environment = "Production"
      Owner       = "Akansha"
    }
  }

  c2 = {
    name                = "aks-dev"
    location            = "centralus"
    resource_group_name = "rg-akansha"
    dns_prefix          = "aksdev"
    default_node_pool = {
      name       = "default"
      node_count = 1
      vm_size    = "Standard_B2s"
    }
    identity_type = "SystemAssigned"
    tags = {
      Environment = "Development"
      Owner       = "Akshay"
    }
  }
}