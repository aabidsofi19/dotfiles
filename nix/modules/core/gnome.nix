{config, pkgs, ... }:
{
 # Enable the X11 windowing system
 services.xserver.enable = true;

 # Enable the GNOME Desktop Environment
 services.xserver.displayManager.gdm.enable = true;
 services.xserver.desktopManager.gnome.enable = true;

 environment.gnome.excludePackages = (with pkgs; [
        gnome-photos
        gnome-tour
        gedit
        cheese
        gnome-music
        gnome-terminal
        epiphany
        geary
        evince
        gnome-characters
        totem
        tali
        iagno
        hitori
        atomix
    ]);

 # Minimal GNOME Shell extensions for productivity
 environment.systemPackages = with pkgs; [
   gnomeExtensions.appindicator
   gnomeExtensions.dash-to-dock
   gnomeExtensions.caffeine
   gnome-tweaks
 ];

 programs.dconf.enable = true;


 # Configure XDG desktop portals
        xdg.portal = {
          enable = true;
          extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
          config.portals = {
            # gtk = null;
            gnome = [
                "org.freedesktop.impl.portal.desktop.gnome"
                "org.freedesktop.impl.portal.screenshot.gnome"
              ];
          };
        };
}
