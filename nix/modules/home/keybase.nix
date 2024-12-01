{ config, pkgs, ... }:
{
  services.keybase = {
    enable = true;
  };

  services.kbfs = {
    enable = true;
    mountPoint = "/keybase"; # default mount point
  };

  home.packages = with pkgs; [
    keybase
    keybase-gui  # if you want the GUI client
  ];
}
