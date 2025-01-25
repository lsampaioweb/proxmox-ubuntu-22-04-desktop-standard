packer {
  required_plugins {
    proxmox = {
      # https://developer.hashicorp.com/packer/integrations/hashicorp/proxmox
      version = "~> 1.2.2"
      source  = "github.com/hashicorp/proxmox"
    }
    ansible = {
      # https://developer.hashicorp.com/packer/integrations/hashicorp/ansible
      version = "~> 1.1.2"
      source  = "github.com/hashicorp/ansible"
    }
  }
}
