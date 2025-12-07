Build with
```sh
nix build .#nixosConfigurations.cwest-usb-iso.config.system.build.isoImage
```

Test with

```sh
qemu-system-x86_64 \                                                                                  
  -enable-kvm \
  -m 4G \
  # You may need to replace this path with a different path
  -cdrom ~/code/nix-configuration/result/iso/nixos-minimal-25.11.20251204.c97c47f-x86_64-linux.iso \
  -boot d
```

Put on a usb with:

```sh
sudo dd if=result/iso/nixos-minimal-25.11.20251204.c97c47f-x86_64-linux.iso of=/dev/sdX bs=1M status=progress
```

