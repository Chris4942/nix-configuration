{ ... }: {
  services.libinput = {
    enable = true;
    touchpad = {
      disableWhileTyping = true;
      tapping = false;
    };
  };
  # environment.etc."libinput/local-overrides.quirks".text = ''
  #   [MacBook(Pro) SPI Touchpads]
  #   MatchName=*Apple SPI Touchpad*
  #   ModelAppleTouchpad=1
  #   AttrTouchSizeRange=200:150
  #   AttrPalmSizeThreshold=1100
  #
  #   [MacBook(Pro) SPI Keyboards]
  #   MatchName=*Apple SPI Keyboard*
  #   AttrKeyboardIntegration=internal
  #
  #   [MacBookPro Touchbar]
  #   MatchBus=usb
  #   MatchVendor=0x05AC
  #   MatchProduct=0x8600
  #   AttrKeyboardIntegration=internal
  # '';
}
