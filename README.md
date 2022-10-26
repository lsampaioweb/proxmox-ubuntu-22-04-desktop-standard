# proxmox-ubuntu-22-04-desktop-standard
Project to create an Ubuntu Desktop template on Proxmox from a cloned template file with the default packages.

Run these commands on the Proxmox node (just once and on any node):
```bash
01 - Create the user that Packer will use.
  pveum user add packer@pve --firstname "Packer" --email "lsampaioweb@gmail.com" --comment "The user that Packer will use."

02 - Create a password for the user.
  pveum passwd packer@pve

03 - Create a token for the user.
  pveum user token add packer@pve packer --comment "The token that Packer will use."

04 - Create a role for the user and set the permissions.
  pveum roleadd Packer -privs "Datastore.AllocateSpace, Datastore.Audit, Sys.Modify, VM.Allocate, VM.Audit, VM.Clone, VM.Config.CDROM, VM.Config.CPU, VM.Config.Cloudinit, VM.Config.Disk, VM.Config.HWType, VM.Config.Memory, VM.Config.Network, VM.Config.Options, VM.Console, VM.Monitor, VM.PowerMgmt"

05 - Set the role to the user and API Token.
  pveum acl modify / -user packer@pve -role Packer
  pveum acl modify / -token 'packer@pve!packer' -role Packer
```

Run these commands on the computer that is running Packer:

```bash
01 - Save the password in the secret manager.
  secret-tool store --label="proxmox-packer-password" password proxmox-packer-password

02 - Save the API token in the secret manager.
  secret-tool store --label="proxmox-packer-token" token proxmox-packer-token

03 - Add the API token of the user to the ~/.bashrc file.
  nano ~/.bashrc
  # Function to unlock gnome keyring for headless logins.
  function unlock-keyring ()
  {
    read -rsp "Type your password: " pass
    export $(echo -n "$pass" | gnome-keyring-daemon --replace --unlock)
    unset pass

    export PKR_VAR_PROXMOX_PACKER_TOKEN=$(secret-tool lookup token "proxmox-packer-token")
  }

04 - Run the unlock-keyring command on the terminal to unlock the secret - manager.
  source ~/.bashrc
  unlock-keyring

05 - Run Packer to create the template.
  cd packer
  packer init config.pkr.hcl
  
  packer build -only="credencials.null.password" .
  packer build -only="machine.proxmox-clone.template" .
  or 
  ./pipeline.sh
```

# Links:

[Links](links.md "Links")

# License:

[MIT](LICENSE "MIT License")

# Created by: 

1. Luciano Sampaio.
