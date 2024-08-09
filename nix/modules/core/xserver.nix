{ pkgs, username, ... }:
{
# services.desktopManager.cosmic.enable = true
# services.displayManager.cosmic-greeter.enable = true
  # services.xserver.displayManager.gdm.enable = true;
  services = {

  desktopManager = {
    cosmic.enable = true;
    # cosmic-greeter.enable = true;
  };

    xserver = {
      enable = true;
      xkb.layout = "us,fr";
      # desktopManager.cosmic.enable = true;
      # displayManager.cosmic-greeter.enable = true;
      # desktopManager.gnome.enable = true;
    };

    # displayManager.autoLogin = {
    #   enable = true;
    #   user = "aabid";
    # };
    displayManager.cosmic-greeter.enable = true;
    libinput = {
      enable = true;
      # mouse = {
      #   accelProfile = "flat";
      # };
    };
  };
  # To prevent getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
