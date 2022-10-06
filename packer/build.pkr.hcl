build {
  name = "void"

  sources = ["source.arm-image.rpi", "source.arm-image.rpi4"]

  # Ensure xbps is updated before we can install/update any other packages.
  provisioner "shell" {
    inline = [
      "xbps-install -Syu xbps",
    ]
  }

  # We need to install openssl-c_rehash on arm6 / arm7 because openssl rehash
  # doesn't work correctly under qemu for these architectures. This leaves xbps
  # unable to validate the void repo SSL certs if the ca-certificates package is
  # updated in the next step).
  provisioner "shell" {
    inline = [
      "xbps-install -Sy openssl-c_rehash"
    ]
    only = ["arm-image.rpi"]
  }

  # Update all packages.
  provisioner "shell" {
    inline = [
      "xbps-install -Syu",
    ]
  }

  # Run c_rehash on arm6 / arm7 in case ca-certificate hashes need to be
  # regenerated (if the previous step updated the ca-certificates package).
  provisioner "shell" {
    inline = [
      "c_rehash",
    ]
    only = ["arm-image.rpi"]
  }

  # Install python3
  provisioner "shell" {
    inline = [
      "xbps-install -y python3",
    ]
  }

  # Enable dhcpcd, sshd and ntp services on rpi4.
  # It would be nice to eventually replace this with an ansible provisioner.
  provisioner "shell" {
    inline = [
      "ln -sf /etc/sv/dhcpcd /etc/runit/runsvdir/default",
      "ln -sf /etc/sv/sshd /etc/runit/runsvdir/default",
      "ln -sf /etc/sv/ntpd /etc/runit/runsvdir/default",
    ]
  }

  # Cleanup.
  # We can remove openssl-c_rehash again afterwards as we won't need it again.
  provisioner "shell" {
    inline = [
      "xbps-install -y python3",
      "xbps-remove -Ry base-voidstrap openssl-c_rehash",
    ]
  }
}
