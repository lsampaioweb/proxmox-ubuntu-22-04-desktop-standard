source "proxmox-clone" "template" {
  # https://www.packer.io/plugins/builders/proxmox/clone

  # Proxmox authentication
  proxmox_url = "${var.proxmox_url}"
  username    = "${var.username}"
  token       = "${var.token}"

  # General
  node                 = "${var.node}"
  vm_id                = "${var.vm_id}"
  vm_name              = "${var.vm_name}"
  pool                 = "${var.pool}"
  onboot               = "${var.onboot}"
  task_timeout         = "${var.task_timeout}"
  template_description = "${var.template_description}"

  # Clone
  clone_vm   = "${var.clone_vm}"
  full_clone = "${var.full_clone}"

  # OS
  os = "${var.os}"
  vga {
    type   = "${var.vga.type}"
    memory = "${var.vga.memory}"
  }

  # System
  qemu_agent      = "${var.qemu_agent}"
  scsi_controller = "${var.scsi_controller}"

  # CPU
  sockets  = "${var.sockets}"
  cores    = "${var.cores}"
  cpu_type = "${var.cpu_type}"

  # Memory
  memory = "${var.memory}"

  # SSH Connection with the template
  ssh_username = "${var.ssh_username}"
  ssh_password = "${file(local.path_password)}"
  ssh_timeout  = "${var.ssh_timeout}"
}

build {
  name = "machine"

  sources = ["source.proxmox-clone.template"]

  provisioner "ansible" {
    playbook_file = "${local.path_ansible_scripts}/template.yml"

    extra_arguments = [
      "--extra-vars",
      "hostname=${var.vm_name}"
    ]

    // This is a bug/workaround and I didn't like it. 
    // TODO - Find a better solution.
    ansible_ssh_extra_args = ["-oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedKeyTypes=+ssh-rsa"]
  }
}
