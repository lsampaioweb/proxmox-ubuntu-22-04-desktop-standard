# proxmox-ubuntu-desktop-standard
Project with Packer and Ansible scripts to create an Ubuntu Desktop template on Proxmox from a cloned virtual machine with the default packages and updates.

This repository uses sub-modules:<br/>
1. [packer-proxmox-ubuntu-clone](https://github.com/lsampaioweb/packer-proxmox-ubuntu-clone "packer-proxmox-ubuntu-clone").
1. [ansible-common-tasks](https://github.com/lsampaioweb/ansible-common-tasks "ansible-common-tasks").
1. [ansible-kvm-cloud-init](https://github.com/lsampaioweb/ansible-kvm-cloud-init "ansible-kvm-cloud-init").

In order to download all the submodules, you have to run the followinng commands:

```bash
  git submodule --init
  git pull --recurse-submodules

  # Or in just one line:
  git submodule update --init --recursive
```

Run these commands to execute Packer:

```bash
  cd packer
#   ./pkr.sh $1 $2 $3 $4
#   $1 -> validate or build.
#   $2 -> home or homelab.
#   $3 -> abort, ask, run-cleanup-provisioner or cleanup.
#   $4 -> debug.
#   e.g:
# ./pkr.sh validate home
# ./pkr.sh build home ask debug
  ./pkr.sh build home
  ./pkr.sh build homelab
```

#
### Created by:

1. Luciano Sampaio.
