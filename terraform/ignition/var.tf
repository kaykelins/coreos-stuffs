variable "ssh_public_key" {
  description = "std key to access"
  default = " "
}
variable "default_network_config" {
  default = "[Match]\nName=en*\n\n[Network]\nAddress=127.0.0.1\nDNS=8.8.8.8"
}
