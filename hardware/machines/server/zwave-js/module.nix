{

  services.zwave-js = {
    enable = true;
    # Normally 3000, but gitea is on 3000, so zwave-js has to go on something else. 3500 is totally arbitrary.
    port = 3500;
    serialPort = "/dev/serial/by-id/usb-Zooz_800_Z-Wave_Stick_533D004242-if00";
    secretsConfigFile = "/secrets/zwave-js-keys.json";
  };
}
