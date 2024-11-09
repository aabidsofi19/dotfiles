{ config, pkgs, ... }:
{
  services.keybase = {
    enable = true;
  };

  services.kbfs = {
    enable = true;
    mountPoint = "/keybase"; # default mount point
  };

  environment.systemPackages = with pkgs; [
    keybase
    keybase-gui  # if you want the GUI client
  ];
}
