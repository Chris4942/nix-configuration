Rebuild locally
```sh
sudo nixos-rebuild switch --flake .#cwest-nixos-macbook
```

Rebuild on walnut (this is faster if the linux kernel version has changed since it has to be rebuilt for mac hardware)
```sh
sudo nixos-rebuild switch --flake .#cwest-nixos-macbook --build-host cwest@walnut --fast
```
