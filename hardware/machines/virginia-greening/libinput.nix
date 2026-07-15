{ ... }: {
  services.libinput = {
    enable = true;
    # touchpad = {
    #   disableWhileTyping = true;
    #   tapping = false;
    # };
  };

  # Use `libinput measure touch-size` to figure out these values
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Macbook Touchpad]
    MatchName=*Apple*Internal*Trackpad*
    ModelAppleTouchpad=1
    AttrSizeHint=162x100.5
    AttrTouchSizeRange=200:150
    AttrPalmSizeThreshold=200

    [MacBook(Pro) SPI Keyboards]
    MatchName=*Apple SPI Keyboard*
    AttrKeyboardIntegration=internal

    [MacBookPro Touchbar]
    MatchBus=usb
    MatchVendor=0x05AC
    MatchProduct=0x8600
    AttrKeyboardIntegration=internal
  '';
}
