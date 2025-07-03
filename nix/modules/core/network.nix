{ pkgs, ... }:

{
  networking = {
    hostName = "nixos";

    hosts = {
      "147.75.47.9"     = [ "meshery-metal-1" ];
      "147.28.149.165"  = [ "meshery-metal-2" ];
      "139.178.83.85"   = [ "meshery-metal-3" ];

      "127.0.0.1" =   ["playground.exoscale.com" "exoscale.localhost" "cloud.com" "exoscale.cloud.com"];
    };

    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" ];

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 59010 59011 ];
      allowedUDPPorts = [ 59010 59011 ];

      # Optional port ranges (uncomment if needed)
      # allowedUDPPortRanges = [
      #   { from = 4000; to = 4007; }
      #   { from = 8000; to = 8010; }
      # ];
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
