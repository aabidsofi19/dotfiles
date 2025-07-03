{ pkgs, config, inputs, ... }: 
{

  home.sessionVariables = {
      WINEPREFIX = "/run/media/aabid/external-ntfs/wineprefix";
  };

  
  home.packages = with pkgs;[

    steam
    
    rpcs3
    ryujinx
    cemu
    ppsspp-sdl
    pcsx2

    ## Utils
    gamemode
    vkbasalt
    vkbasalt-cli
    vulkan-tools
    gamescope
    mangohud
    logmein-hamachi

    
    wineWowPackages.stable  # 32-bit + 64-bit Wine
    winetricks
    # Optional tools
    bottles
    lutris
    # winetricks
    # inputs.nix-gaming.packages.${pkgs.system}.wine-ge
    # 
    # support both 32-bit and 64-bit applications
    # wineWowPackages.stable

  
    # # wine-staging (version with experimental features)
    # wineWowPackages.staging

    # winetricks (all versions)
    # winetricks
    # lutris

    # native wayland support (unstable)
    # wineWowPackages.waylandFull
   ];

    ##########################
    # Gamemode & Overlays
    ##########################
    # programs.gamemode.enable = true;
    
 # programs.vkBasalt.enable = true;
   



}
