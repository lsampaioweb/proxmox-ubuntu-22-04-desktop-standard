#!/bin/bash
set -e # Abort if there is an issue with any build.

# Usage:
#   ./pkr.sh $1 $2
#   $1 -> validate or build.
#   $2 -> home or homelab.
#   $3 -> abort, ask, run-cleanup-provisioner or cleanup.
#   $4 -> debug.
#   e.g:
#   ./pkr.sh validate home
#   ./pkr.sh build home ask debug
#   ./pkr.sh build home

# Initialize (download) the packer plugins.
packer init config.pkr.hcl

# Format all the current and child folders.
packer fmt -recursive .

action=${1:-validate}
environment=${2:-home}
onErrorAction=${3:-cleanup}

if [ "$action" = "build" ]; then
  errorAction="-on-error=$onErrorAction"
else
  errorAction=""
fi

debug=0
if [ "$4" = "debug" ]; then
  debug=1
fi

PACKER_LOG=$debug packer $action $errorAction -only="credentials.null.password" -var-file=env/$environment/vars.pkrvars.hcl clone/.

PACKER_LOG=$debug packer $action $errorAction -only="build.proxmox-clone.template" -var-file=env/$environment/vars.pkrvars.hcl clone/.

PACKER_LOG=$debug packer $action $errorAction -only="post-config.null.extra-config" -var-file=env/$environment/vars.pkrvars.hcl clone/.
