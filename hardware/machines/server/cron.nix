{ pkgs, ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/1 * * * *      root    ${pkgs.rysnc}/bin/rsync -avn /mnt/main/ /mnt/backup/ >> /tmp/rsync.log"
    ];
  };
}
