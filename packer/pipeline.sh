#!/bin/bash
set -e # Abort if there is an issue with any build.

packer build -only="credencials.null.password" .
packer build -only="machine.proxmox-clone.template" .
