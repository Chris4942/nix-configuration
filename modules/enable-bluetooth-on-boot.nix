{pkgs, ... }: {
  systemd.user.services.bt-power-on = {
    description = "Ensure Bluetooth is powered on";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bluez}/bin/bluetoothctl power on";
    };
  };
}
