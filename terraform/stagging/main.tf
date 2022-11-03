module "proxmox-ubuntu-22-04" {
  source = "../modules/proxmox-ubuntu-22-04"

  clone       = "ubuntu-22-04-desktop-standard"
  name        = "ubuntu-22-04-desktop-standard-vm-production"
  description = "Ubuntu 22.04 VM with the default applications and settings"
  pool        = ""
}
