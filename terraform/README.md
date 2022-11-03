# proxmox-ubuntu-22-04-desktop-standard
Project with Terraform and Ansible scripts to create an Ubuntu Desktop template on Proxmox from a cloned virtual machine with the default packages and updates.

Run these commands on the Proxmox node (just once and on any node):
```bash
  01 - Create the user that Terraform will use.
    pveum user add terraform@pve --firstname "Terraform" --email "lsampaioweb@gmail.com" --comment "The user that Terraform will use."

  02 - Create a password for the user.
    uuid
    pveum passwd terraform@pve

  03 - Create a token for the user.
    pveum user token add terraform@pve terraform --comment "The token that Terraform will use."

  04 - Create a role for the user and set the permissions.
    pveum roleadd Terraform -privs "Datastore.AllocateSpace, Datastore.Audit, Group.Allocate, Pool.Audit, Pool.Allocate, Sys.Audit, Sys.Modify, VM.Allocate, VM.Audit, VM.Clone, VM.Config.CDROM, VM.Config.CPU, VM.Config.Cloudinit, VM.Config.Disk, VM.Config.HWType, VM.Config.Memory, VM.Config.Network, VM.Config.Options, VM.Console, VM.Monitor, VM.PowerMgmt"

  05 - Set the role to the user and API Token.
    pveum acl modify / -user terraform@pve -role Terraform
    pveum acl modify / -token 'terraform@pve!terraform' -role Terraform
```

Run these commands on the computer that is running Terraform:

```bash
  01 - Save the password in the secret manager.
    secret-tool store --label="proxmox-terraform-password" password proxmox-terraform-password

  02 - Save the API token in the secret manager.
    secret-tool store --label="proxmox-terraform-token" token proxmox-terraform-token

  03 - Add the API token of the user to the ~/.bashrc file.
    nano ~/.bashrc
    # Function to unlock gnome keyring for headless logins.
    function unlock-keyring ()
    {
      read -rsp "Type your password: " pass
      export $(echo -n "$pass" | gnome-keyring-daemon --replace --unlock)
      unset pass

      export PM_API_TOKEN_SECRET=$(secret-tool lookup token "proxmox-terraform-token")
    }

  04 - Run the unlock-keyring command on the terminal to unlock the secret - manager.
    source ~/.bashrc  
    unlock-keyring

  05 - Create the necessary folders and files.
    mkdir modules
    cd modules
    git submodule add https://github.com/lsampaioweb/terraform-proxmox-ubuntu-22-04-module.git proxmox-ubuntu-22-04

    cd ..
    mkdir stagging
    mkdir production

    cd stagging # Repeat these steps for the production folder.
    nano providers.tf
    terraform {
      required_providers {
        proxmox = {
          source  = "Telmate/proxmox"
          version = "2.9.11"
        }
      }
    }

    provider "proxmox" {
      pm_api_url      = "https://proxmoxurl:8006/api2/json"
      pm_api_token_id = "terraform@pve!terraform"
    }

    cd ..
    nano main.tf
    module "proxmox-ubuntu-22-04" {
      source = "../modules/proxmox-ubuntu-22-04"

      clone       = "ubuntu-22-04-desktop-standard"
      name        = "ubuntu-22-04-desktop-standard-vm-stagging"
      description = "Ubuntu 22.04 VM with the default settings"
      pool        = "Stagging"
    }

  06 - Run Terraform to create the VM.
    cd terraform/{stagging or production}
    terraform init

    terraform plan
    terraform apply
```

# Created by: 

1. Luciano Sampaio.
