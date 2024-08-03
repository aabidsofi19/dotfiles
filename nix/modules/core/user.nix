{ pkgs, inputs, username, host, ...}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username host; };
    users.aabid = {
      imports =
        if (host == "desktop") then
          [ ./../home/default.desktop.nix ]
        else [ ./../home ];
      home.username = "aabid";
      home.homeDirectory = "/home/aabid";
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aabid = {
    isNormalUser = true;
    description = "aabid";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
  };
  nix.settings.allowed-users = [ "aabid" ];
}
