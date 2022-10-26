variable "clone_vm" {
  description = "The name of the VM that will be used as a template to be cloned."
  type        = string
  default     = ""
}

variable "full_clone" {
  description = "Whether to run a full or shallow clone from the base clone_vm."
  type        = bool
  default     = true
}
