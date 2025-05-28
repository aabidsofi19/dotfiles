{ pkgs, ... }: 
{
  networking = {
    hostName = "nixos";
    hosts = {
      
     "147.75.47.9" =    "c3-medium-x86-01-meshery";
     "147.28.149.165" = "c3-medium-x86-02-meshery";
     "139.178.83.85" =	"c3-medium-x86-03-meshery" ;
    };
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 59010 59011 ];
      allowedUDPPorts = [ 59010 59011 ];
      # allowedUDPPortRanges = [
        # { from = 4000; to = 4007; }
        # { from = 8000; to = 8010; }
      # ];
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
