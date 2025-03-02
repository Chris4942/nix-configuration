# How to install to a flash drive

Mostly just follow [the instructions from the wiki](https://nixos.wiki/wiki/NixOS_Installation_Guide),
but prepare the drive by encrypting only the NIXROOT portion of it.

Additionally, when creating the boot partition give it `1G` instead of `500M`.

```sh
sudo cryptsetup luksFormat /dev/sda2 # or wherever the volume is
sudo cryptsetup config /dev/sda2 --label ENCRYPTED_NIXROOT # This is required so that it has a consistent name
sudo cryptsetup open /dev/sda2 decrypted # This will decrypt it and the device will have a handle at /dev/mapper/decrypted
```

The device at `/dev/mapper/decrypted` can be formatted and labeled as explained in the wiki instructions.

Make sure to label the decrypted device with `NIXROOT`.
