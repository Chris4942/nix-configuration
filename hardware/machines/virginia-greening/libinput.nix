{ pkgs, ... }: {
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
    # ModelAppleTouchpad=1
    AttrSizeHint=162x100.5
    AttrTouchSizeRange=200:150
    AttrPalmSizeThreshold=10
    AttrPalmPressureThreshold=8

    [MacBook(Pro) SPI Keyboards]
    MatchName=*Apple SPI Keyboard*
    AttrKeyboardIntegration=internal

    [MacBookPro Touchbar]
    MatchBus=usb
    MatchVendor=0x05AC
    MatchProduct=0x8600
    AttrKeyboardIntegration=internal
  '';

  security.sudo = {
    enable = true;
    extraRules = [
      {
        commands = [
          {
            # This script is the solution to a very dumb problem.
            # libinput does not correctly classify palm events even though the detection config above is correct.
            # To find the trackpad, run `sudo libinput list-devices`.
            # The keyboard and trackpad are together, so it will appear twice, but I care about the one that is a pointer.
            # If I run sudo libinput record /dev/input/eventX > palm.yml, it will record the palm motion.
            # If I replay it with sudo libinput replay palm.yml, then those events will be palm detect in the `sudo libinput debug-events` output.
            # If I record events using `evemu-record` and then replay that to the _same_ device it came from palm detections are not detected;
            # However, if I play those events back against a new device created from `sudo libinput replay`, then I _do_ get palm detections.
            # Read and write to/from the events, by just redirecting stdin and stdout
            command = "${./toggle-mouse.sh}";
            options = [ "NOPASSWD" ];
          }
        ];
        groups = [ "wheel" ];
      }
    ];
  };

}
