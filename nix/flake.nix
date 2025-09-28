{
  description = "My personal NixOS configuration";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager, used for managing user configuration
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-ld.url = "github:Mic92/nix-ld";
    # this line assume that you also have nixpkgs as an input
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    # hypr-contrib.url = "github:hyprwm/contrib";
    # hyprpicker.url = "github:hyprwm/hyprpicker";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";

    # nix-gaming.url = "github:fufexan/nix-gaming";

    # hyprland = {
    # type = "git";
    # url = "https://github.com/hyprwm/Hyprland";
    # submodules = true;
    # };
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
    catppuccin-bat = {
        url = "github:catppuccin/bat";
        flake = false;
    };
    catppuccin-cava = {
        url = "github:catppuccin/cava";
        flake = false;
    };
    catppuccin-starship = {
        url = "github:catppuccin/starship";
        flake = false;
    };

    spicetify-nix.url = "github:gerg-l/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    # nixos-cosmic = {
    #    url = "github:lilyinstarlight/nixos-cosmic";
    #    inputs.nixpkgs.follows = "nixpkgs";
    # };

    # zen-browser.url = "github:MarceColl/zen-browser-flake";


    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

  };

  outputs = { self,ghostty,caelestia-cli,caelestia-shell,nix-ld,nixpkgs,home-manager, ... }@inputs:
    let
      username = "aabid";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
            # {
            #     nix.settings = {
            #     substituters = [ "https://cosmic.cachix.org/" ];
            #     trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            #     };
            # }
            # nixos-cosmic.nixosModules.default
            (import ./hosts/desktop)
            {
              security.pam.loginLimits = [
                {
                  domain = "*";
                  type = "hard";
                  item = "memlock";
                  value = "unlimited";
                }
                {
                  domain = "*";
                  type = "soft";
                  item = "memlock";
                  value = "unlimited";
                }
              ];
            }
            ];
            specialArgs = { host="desktop"; inherit self inputs username ; };
        };
      };

      # Import development shells
      devShells.${system} = import ./shells {
        inherit pkgs lib inputs;
      };
    };
}
