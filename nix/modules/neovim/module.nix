{ pkgs, ... }: {
  
 home.file.".config/nvim".source = ./config ;

 programs.neovim.plugins = [
   pkgs.vimPlugins.nvim-treesitter.withAllGrammars
 ];

}
