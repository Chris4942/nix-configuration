{pkgs, ...}: {
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" ''
<monitors version="2">
  <configuration>
    <logicalmonitor>
      <x>0</x>
      <y>0</y>
      <scale>1</scale>
      <primary>yes</primary>
      <monitor>
        <monitorspec>
          <connector>DP-3</connector>
          <vendor>GSM</vendor>
          <product>LG HDR QHD</product>
          <serial>104NTZNAG205</serial>
        </monitorspec>
        <mode>
          <width>2560</width>
          <height>1440</height>
          <rate>59.951</rate>
        </mode>
      </monitor>
    </logicalmonitor>
    <disabled>
      <monitorspec>
        <connector>HDMI-1</connector>
        <vendor>GSM</vendor>
        <product>LG TV SSCR2</product>
        <serial>0x01010101</serial>
      </monitorspec>
    </disabled>
  </configuration>
</monitors>
  ''}"
  ];
}
