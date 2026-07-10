
To build make sure that flakes are enabled and run
```sh
sudo nixos-rebuild switch --flake .#walnut
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
