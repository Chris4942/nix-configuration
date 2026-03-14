{ pkgs, ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 4 * * *      root    ${pkgs.rsync}/bin/rsync -avn /mnt/main/ /mnt/backup/ >> /tmp/rsync.log"
    ];
  };
}
