#!/bin/bash
set -e # Abort if there is an issue with any build.

packer init config.pkr.hcl 
packer build -only="credencials.null.password" -var-file=project.pkrvars.hcl clone/. 
packer build -only="template.proxmox-clone.ubuntu" -var-file=project.pkrvars.hcl clone/. 
