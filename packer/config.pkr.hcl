packer {
  required_plugins {
    proxmox = {
      # https://developer.hashicorp.com/packer/integrations/hashicorp/proxmox
      version = "~> 1.1.8"
      source  = "github.com/hashicorp/proxmox"
    }
    ansible = {
      # https://developer.hashicorp.com/packer/integrations/hashicorp/ansible
      version = "~> 1.1.1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}
