{ ... }:
{
  services = {

    logmein-hamachi.enable=true;
    gvfs.enable = true;
    flatpak.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    fstrim.enable = true;

    openssh.enable = true;

    
    tailscale = {
      enable = true;
      useRoutingFeatures = "client"; # or "server" if you want subnet routing
    };
   };
  
  services.openssh.settings.PasswordAuthentication = true;
  # services.openssh.port = 22;
  # services.openssh.protocol = "2";
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';

 }
