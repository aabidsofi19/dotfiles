{ pkgs, ... }: {
  # .zshenv
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    history = {
      ignoreDups = true;
      save = 1000000;
      size = 1000000;
    };

    shellAliases = {
      vi = "nvim";
      c = "clear";
      p = "pijul";
      open = "xdg-open";
    };

    initExtra = ''
         '';

    oh-my-zsh = {
      enable = true;
      # theme = "ys";
      plugins = [
        "aws"
        "docker"
        "encode64"
        "git"
        "git-extras"
        "man"
        "nmap"
        "ssh-agent"
        "sudo"
        "systemd"
        "tig"
        "tmux"
        "vi-mode"
        "yarn"
        "zsh-navigation-tools"
        "mix"
        "pijul"
      ];
    };
  };
}
