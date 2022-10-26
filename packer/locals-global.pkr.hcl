locals {
  path_temp_files = "tmp"
  path_password   = "${local.path_temp_files}/.password"

  path_ansible_scripts = "../ansible"
}
