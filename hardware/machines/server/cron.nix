{ ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 4 * * * *      root    sudo rsync -av /mnt/main/ /mnt/backup/ >> /tmp/rsync.log"
    ];
  };
}
