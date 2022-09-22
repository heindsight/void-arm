source "arm-image" "rpi4" {
  iso_url      = "https://repo-default.voidlinux.org/live/current/void-rpi4-20210930.img.xz"
  iso_checksum = "2cef9bc4a6cb43581cb1512fa84cd4f459ebee4e76a3cfbc2f077d72fa9c2e83"
  qemu_binary  = "qemu-aarch64-static"
  image_type   = "raspberrypi"
  image_mounts = ["/boot", "/"]
  resolv-conf  = "copy-host"
}

source "arm-image" "rpi" {
  iso_url      = "https://repo-default.voidlinux.org/live/current/void-rpi-20210930.img.xz"
  iso_checksum = "baffd016be8e716f0443410cd7da9bcd8aef4cc98c28ac22bb6bbea637a22dc7"
  qemu_binary  = "qemu-arm-static"
  image_type   = "raspberrypi"
  image_mounts = ["/boot", "/"]
  resolv-conf  = "copy-host"
}
