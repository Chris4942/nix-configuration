{ pkgs, ... }:
{
  imports = [ ./config.nix ];
  environment.systemPackages = with pkgs; [
    neovim-node-client
  ];
}
