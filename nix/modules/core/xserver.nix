{ pkgs, username, ... }:
{

  services = {
    xserver = {
      enable = true;
      xkb.layout = "us,fr";
    };

    libinput = {
      enable = true;
    };
  };
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
