variable "resource_group_name" { type = string }
variable "name"                { type = string  default = "wk2" }
# Gebruik een absoluut pad (geen ~)
variable "ssh_public_key_path" { type = string  default = "/home/student/.ssh/azure.pub" }
