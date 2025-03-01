# How to install to a flash drive

> Note: I'm still testing, but this _should_ work

```sh
# format flash drive
sudo mkfs.ext4 /dev/sda # or wherever your flash drive is or the partition you want to use
mkdir /mnt # only required if /mnt doesn't already exists
sudo mount /dev/sda /mnt
sudo sudo nixos-install --flake .#cwest-usb # assuming that your at the root of this repo
```
