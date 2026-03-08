{ ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 4 * * * *      root    rsync -av /mnt/main/ /mnt/backup/ >> /tmp/rsync.log"
    ];
  };
}
