{ inputs, pkgs, ...}:
{
  home.packages = with pkgs; [
    # swww
    swaybg
    #inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    hyprpicker
    hyprlock
    grim
    slurp
    wl-clip-persist
    wl-clipboard
    cliphist
    inotify-tools
    trash-cli
    #adw-gtk-theme
    app2unit
    papirus-icon-theme
    libsForQt5.qt5ct
    kdePackages.qt6ct
    qt6ct
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
    wf-recorder
    glib
    wayland
    direnv
    rose-pine-hyprcursor
  ];
  # systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      # hidpi = true;
    };
    # enableNvidiaPatches = false;
    systemd.enable = true;
  };


  home.file.".config/hypr".source = ./config;
}
