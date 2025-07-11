{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];



  fileSystems."/mnt/storage" = {
    device = "/dev/disk/by-uuid/ad78d178-ec23-4761-a223-0c6925a3a12a";
    fsType = "ext4";
  };

  fileSystems."/home" = {
    device = "/mnt/storage/home";
    fsType = "none";
    options = [ "bind" ];
  };

  
  powerManagement.cpuFreqGovernor = "performance";
  programs.steam.enable = true;
}
