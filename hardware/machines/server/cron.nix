{ ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 4 * * *      root    rsync -avn /mnt/main/ /mnt/backup/ >> /tmp/rsync.log"
    ];
  };
}
