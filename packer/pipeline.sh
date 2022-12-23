#!/bin/bash
set -e # Abort if there is an issue with any build.

packer init config.pkr.hcl 

# packer validate -only="credencials.null.password" -var-file=project.pkrvars.hcl clone/. 
packer build -only="credencials.null.password" -var-file=project.pkrvars.hcl clone/. 

# packer validate -only="ubuntu.proxmox-clone.template" -var-file=project.pkrvars.hcl clone/. 
packer build -only="ubuntu.proxmox-clone.template" -var-file=project.pkrvars.hcl clone/. 
