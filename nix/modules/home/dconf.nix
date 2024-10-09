{ pkgs, ... }:
{
  # Enable dconf in home-manager
  dconf.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      enable-hot-corners = false;
      show-battery-percentage = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "kitty.desktop"
        "zed.desktop"
        "firefox.desktop"
      ];
    };
  };
}
