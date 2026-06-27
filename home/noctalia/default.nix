{ noctalia-flake, ... }:
{
  imports = [
    noctalia-flake.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "compact";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "number";
            }
          ];
          center = [
            {
              formatHorizontal = "dd-MMM-yyyy HH:mm:ss";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
          right = [
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Monochrome";
      general = {
        avatarImage = "/home/drfoobar/.face";
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = true;
        name = "Washington, DC, United States";
      };
    };
    colors = {
      mPrimary = "#a9b665";
      mOnPrimary = "#32302f";
      mSecondary = "#e78a4e";
      mOnSecondary = "#32302f";
      mTertiary = "#89b482";
      mOnTertiary = "#32302f";
      mError = "#ea6962";
      mOnError = "#32302f";
      mSurface = "#32302f";
      mOnSurface = "#ddc7a1";
      mSurfaceVariant = "#3c3836";
      mOnSurfaceVariant = "#d4be98";
      mSurfaceDim = "#282828";
      mOnSurfaceDim = "#928374";
      mOutline = "#504945";
      mOutlineVariant = "#3c3836";
      mShadow = "#282828";
      mHover = "#7daea3";
      mOnHover = "#32302f";
    };
  };
  home.file.".cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = ../../data/backgrounds/wallhaven-1p75xv_2560x1440.png;
      wallpapers = { };
    };
  };
}
