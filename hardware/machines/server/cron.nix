{ pkgs, ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/1 * * * *      root    ${pkgs.rsync}/bin/rsync -avn /mnt/main/ /mnt/backup/ >> /tmp/rsync.log"
    ];
  };
}
