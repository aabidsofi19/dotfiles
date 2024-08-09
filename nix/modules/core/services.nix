{ ... }:
{
  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    fstrim.enable = true;

    openssh.enable = true;
    openssh.permitRootLogin = "yes";
    openssh.passwordAuthentication = true;
    openssh.port = 22;
    openssh.x11Forwarding = true;
    openssh.allowTcpForwarding = true;
    openssh.allowAgentForwarding = true;
  };
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';
}
