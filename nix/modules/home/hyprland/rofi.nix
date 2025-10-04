
{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      terminal = "ghostty";
      drun-display-format = "{name}";
      location = 0;
      width = 30;
    };

   theme = "./theme.rasi";

  };

  home.file.".config/rofi/theme.rasi".source = ./config/rofi/theme.rasi;
}
