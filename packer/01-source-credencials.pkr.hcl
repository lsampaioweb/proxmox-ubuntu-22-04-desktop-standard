source "null" "password" {
  communicator = "none"
}

build {
  name = "credencials"

  sources = ["source.null.password"]

  provisioner "shell-local" {
    inline = [
      # Make sure the folder exists.
      "mkdir -p ${local.path_temp_files}",

      # Get the password from the secret manager and create a file with its value.
      "echo -n $(secret-tool lookup password ${var.clone_vm}) > ${local.path_password}",

      # Get the password from the file and save it in the secret manager with the name of the new template.
      # This is done for the templates that will clone from this template.
      "echo -n $(cat ${local.path_password}) | secret-tool store --label='${var.vm_name}' password '${var.vm_name}'"
    ]
  }
}
