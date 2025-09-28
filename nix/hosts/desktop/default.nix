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


  # Optimize for no crashes and performance
  

   systemd.extraConfig = ''
    # Enable accounting globally
    DefaultCPUAccounting=yes
    DefaultMemoryAccounting=yes
  '';

  systemd.slices = {
    "user.slice" = {
      description = "User Slice";
      sliceConfig = {
        CPUAccounting = "yes";
        MemoryAccounting = "yes";
        CPUQuota = "80%";
      };
    };

    "system.slice" = {
      description = "System Slice";
      sliceConfig = {
        CPUAccounting = "yes";
        MemoryAccounting = "yes";
        MemoryLow = "1G";
      };
    };
  };

  zramSwap = {
    enable = true;          # Enable zram swap
    memoryPercent = 25;    # Use 100% of RAM size as zram (adjust to taste)
    priority = 100;         # Swap priority (higher than disk swap)
  };


#Kills processes earlier and more gracefully than the kernel OOM.
services.earlyoom = {
  enable = true;
  freeMemThreshold = 5;   # kill if 5% of RAM is only free
  freeSwapThreshold = 5;  # % of swap
};

  # Protect critical desktop processes from being killed
  systemd.services."display-manager".serviceConfig.OOMScoreAdjust = -900;
  # Example: KDE Plasma shell
  systemd.user.services."plasmashell".serviceConfig.OOMScoreAdjust = -800;
  # gnome
  systemd.user.services."gnome-shell".serviceConfig.OOMScoreAdjust = -800;
  # hyprland
  systemd.user.services."hyprland".serviceConfig.OOMScoreAdjust = -800;

  # Enable zram (compressed swap in RAM)
  # services.zramSwap.enable = true;
  # services.zramSwap.memoryPercent = 25; # use 25% of RAM as zram
}
