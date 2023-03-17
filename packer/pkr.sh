#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
#   ./pkr.sh validate staging
#   $1 -> validate, build.
#   $2 -> staging, production.

# Initialize (download) the packer plugins.
packer init config.pkr.hcl

# Format all the current and child folders.
packer fmt -recursive .

packer $1 -only="credencials.null.password" -var-file=$2/vars.pkrvars.hcl clone/. 

packer $1 -only="ubuntu.proxmox-clone.template" -var-file=$2/vars.pkrvars.hcl clone/. 

packer $1 -only="kvm-node.null.extra-config" -var-file=$2/vars.pkrvars.hcl clone/. 
