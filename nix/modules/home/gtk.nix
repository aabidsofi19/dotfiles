{ pkgs, config, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.nerdfonts
    (pkgs.nerdfonts.override { fonts = [ "FiraCode"  "JetBrainsMono" "Noto" ]; })
    pkgs.twemoji-color-font
    pkgs.helvetica-neue-lt-std
    pkgs.noto-fonts-emoji
  ];

  gtk = {
    enable = true;
    # font = {
    #   name = "Helvetica Neue LT Std";
    #   size = 11;
    # };
    # iconTheme = {
    #   name = "Papirus-Dark";
    #   package = pkgs.catppuccin-papirus-folders.override {
    #     flavor = "mocha";
    #     accent = "lavender";
    #   };
    # };
    # theme = {
    #   name = "Dracula";
    #   package = pkgs.dracula-theme;
    # };
    # cursorTheme = {
    #   name = "Nordzy-cursors";
    #   package = pkgs.nordzy-cursor-theme;
    #   size = 22;
    # };
  };

  # home.pointerCursor = {
  #   name = "Nordzy-cursors";
  #   package = pkgs.nordzy-cursor-theme;
  #   size = 22;
  # };
}
