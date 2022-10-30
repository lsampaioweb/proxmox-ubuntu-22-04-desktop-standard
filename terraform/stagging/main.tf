module "proxmox-ubuntu-22-04" {
  source = "../modules/proxmox-ubuntu-22-04"

  clone = "ubuntu-22-04-server-raw"
  name  = "ubuntu-22-04-server-raw-vm-stagging"
}
