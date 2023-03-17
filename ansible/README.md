# proxmox-ubuntu-22-04-desktop-standard
Project with Ansible scripts to create an Ubuntu Desktop template on Proxmox from a cloned virtual machine with the default packages and updates.

Run the command in the terminal:
```bash
  ansible-playbook template.yml -e "hostname=ubuntu-22-04-desktop-standard"
  ansible-playbook kvm_setup.yml -e "node=kvm-07 vm_id=905 hotplug=disk,network,cpu storage_pool=Ceph_Silver"
```

# Created by: 

1. Luciano Sampaio.
