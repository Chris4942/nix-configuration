
To build make sure that flakes are enabled and run
```sh
sudo nixos-rebuild switch --flake .#cwest-nixos-1
```


---

To set up home-manager on steam deck put the following in `/etc/nix/nix.conf`
```
extra-experimental-features = flakes nix-command
```

and then you can run

```sh
homemanager switch --flake .#deck
```

You'll need to re-run this after any major steam os update.
