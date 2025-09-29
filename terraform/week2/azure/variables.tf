variable "resource_group_name" {
  type    = string
  default = "J2"
}

# Dit is voor m'n naamgeving. J2 omdat het leerjaar 2 van (iac) is.
variable "name" {
  type    = string
  default = "J2"
}

variable "ssh_public_key_path" {
  type    = string
  default = "/home/student/.ssh/azure.pub"
}

variable "subscription_id" {
  type = string
}
