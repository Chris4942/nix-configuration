{ ... }:
let
  gitea-port = 3000;
in
{
  services.gitea = {
    enable = true;
    stateDir = "/mnt/main/gitea/";
    settings = {
      server = {
        HTTP_ADDR = "0.0.0.0";
        HTTP_PORT = gitea-port; # The default, but explicit so I can tell what it is
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ gitea-port ];
}
