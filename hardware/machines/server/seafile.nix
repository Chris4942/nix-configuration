{ ... }:
{
  services.seafile = {
    adminEmail = "cjwest4942@gmail.com";
    initialAdminPassword = "initialAdminPassword";
    ccnetSettings.General.SERVICE_URL = "https://seafile.example.com";
    dataDir = "/mnt/main/seafile/";
    seafileSettings = {
      fileserver = {
        host = "unix:/run/seafile/server.sock";
      };
    };
  };
}
