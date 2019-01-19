data "ignition_user" "core" {
    name = "core"
    ssh_authorized_keys  = ["${var.ssh_public_key}"]
    shell = "/bin/bash"
}
data "ignition_systemd_unit" "docker" {
  name = "docker.service"
  enabled = true
}
data "ignition_networkd_unit" "network_config" {
    name = "static.network"
    content = "${var.default_network_config}"
}
data "ignition_config" "config" {
  systemd = [
    "${data.ignition_systemd_unit.docker.id}",
  ]
  networkd = [
      "${data.ignition_networkd_unit.network_config.id}"
  ]
  users = [
      "${data.ignition_user.core.id}"
  ]

}
resource "local_file" "init" {
    content     = "${data.ignition_config.config.rendered}"
    filename = "./ignition.json"
}
