{ ... }:
{
  services.postgresql = {
    enable = true;
    dataDir = "/mnt/main/postgres/";
  };
}
