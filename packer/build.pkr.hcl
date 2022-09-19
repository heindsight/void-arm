build {
  name = "void"

  sources = ["source.arm-image.rpi4"]

  provisioner "shell" {
    inline = [
      "xbps-install -Syu xbps",
      "xbps-install -Syu",
      "xbps-install -y python3",
      "xbps-remove -y base-voidstrap",
    ]
  }

  provisioner "shell" {
    inline = [
      "ln -s /etc/sv/dhcpcd /etc/runit/runsvdir/default",
      "ln -s /etc/sv/sshd /etc/runit/runsvdir/default",
      "ln -s /etc/sv/ntpd /etc/runit/runsvdir/default",
    ]
  }

  post-processor "arm-image" {
  }
}
