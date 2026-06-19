{ ... }:
{
  services.gitea = {
    enable = true;
    stateDir = "/mnt/main/gitea/";
    settings = {
      server = {
        HTTP_ADDR = "west-server";
        HTTP_PORT = 3000; # The default, but explicit so I can tell what it is
      };
    };
  };
}
