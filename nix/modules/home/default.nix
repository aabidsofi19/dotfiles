{inputs, username,lib, host, ...}: {
  imports =
       # [(import ./aseprite/aseprite.nix)]       # pixel art editor
    # [(import ./audacious/audacious.nix)]          # music player
     [(import ./bat.nix)]                       # better cat command
    ++ [(import ./btop.nix)]                      # resouces monitor
    ++ [(import ./cava.nix)]                      # audio visualizer
    # ++ [(import ./discord.nix)]                   # discord with catppuccin theme
    # ++ [(import ./floorp/floorp.nix)]             # firefox based browser
    ++ [(import ./fuzzel.nix)]                    # launcher
    ++ [(import ./gaming.nix)]                    # packages related to gaming
    ++ [(import ./git.nix)]                       # version control
    ++ [(import ./gtk.nix)]                       # gtk theme
    ++ [(import ./hyprland)]                      # window manager
    ++ [(import ./kitty.nix)]                     # terminal
    # ++ [(import ./swaync/swaync.nix)]             # notification deamon
    # ++ [(import ./micro.nix)]                     # nano replacement
    ++ [(import ./packages.nix)]                  # other packages
    # ++ [(import ./retroarch.nix)]
    ++ [(import ./scripts/scripts.nix)]           # personal scripts
    # ++ [(import ./spicetify.nix)]                 # spotify client
    ++ [(import ./starship.nix)]                  # shell prompt
    # ++ [(import ./swaylock.nix)]                  # lock screen
    # ++ [(import ./vscodium.nix)]                  # vscode forck
    # ++ [(import ./waybar)]                        # status bar
    ++ [(import ./zsh.nix)]                       # shell
    ++ [(import ./dconf.nix)]                     # dconf settings
    ++ [(import ./nvim/default.nix)]                     # neovim editor
    ++ [(import ./keybase.nix)]
    ++ [(import ./caelestia.nix)]                 # caelestia shell 
    # ++ [(import ./playwright.nix)]
     ;              # browser automation and testing



    home.sessionPath = ["~/go/bin"];
    home.file.".npmrc".text = lib.generators.toINIWithGlobalSection {} {
      globalSection = {
        prefix = "/home/aabid/.npm-packages";
      };
    };

}
