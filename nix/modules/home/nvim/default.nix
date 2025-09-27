
{ pkgs,inputs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };


  home.packages = with pkgs; [
      # Lua
      lua-language-server

      # Python
      pyright

      # Web
      nodePackages.typescript-language-server
      nodePackages.typescript
      nodePackages.vscode-langservers-extracted  # html, css, json, eslint
      # language servers for all web languages

      # Go
      gopls

      # Bash
      bash-language-server
  ];

  home.file.".config/nvim".source = ./config;
}
