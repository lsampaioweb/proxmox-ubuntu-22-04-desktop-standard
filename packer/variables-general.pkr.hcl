variable "node" {
  description = "The node in the Proxmox cluster to create the template."
  type        = string
  default     = "kvm-01"
}

variable "vm_id" {
  description = "The ID used to reference the virtual machine. This will also be the ID of the final template. If not given, the next free ID on the node will be used."
  type        = number
}

variable "vm_name" {
  description = "Name of the virtual machine during creation. If not given, a isotime will be used."
  type        = string
}

variable "pool" {
  description = "Name of resource pool to create virtual machine in."
  type        = string
  default     = "Template"
}

variable "onboot" {
  description = "Specifies whether a VM will be started during system bootup. Defaults to false."
  type        = bool
  default     = false
}

variable "task_timeout" {
  description = "The timeout for Promox API operations, e.g. clones. Defaults to 1 minute."
  type        = string
  default     = "10m"
}

variable "template_description" {
  description = "Description of the template, visible in the Proxmox interface."
  type        = string
  default     = "Ubuntu 22.04 template generated by Packer on {{ isotime `2006-01-02` }}."
}
