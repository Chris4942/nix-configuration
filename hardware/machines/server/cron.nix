{ pkgs, ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 4 * * *      root    ${pkgs.rsync}/bin/rsync -av /mnt/main/ /mnt/backup/ >> /tmp/rsync.log"
    ];
  };
}
