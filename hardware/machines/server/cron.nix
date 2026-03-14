{ ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/1 * * * *      root    rsync -avn /mnt/main/ /mnt/backup/ >> /tmp/rsync.log"
    ];
  };
}
