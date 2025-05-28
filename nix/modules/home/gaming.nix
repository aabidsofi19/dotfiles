{ pkgs, config, inputs, ... }: 
{
  home.packages = with pkgs;[
    ## Utils
    # gamemode
    # gamescope
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
}
