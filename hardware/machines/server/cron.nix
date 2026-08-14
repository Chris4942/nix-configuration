{ pkgs, ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 4 * * *      root    ${pkgs.rsync}/bin/rsync -av /mnt/main/ /mnt/backup/ >> /tmp/rsync.log"
      # Reboot everyday at 3 AM because sometimes tailscale gets out of wack and rebooting seems to fix it.
      # This is a stopgap until I can fix that
      "0 3 * * *      root    reboot"
    ];
  };
}
