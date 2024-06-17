{ pkgs, ... }: {
  
 programs.neovim.plugins = [
   pkgs.vimPlugins.nvim-treesitter.withAllGrammars
 ];

}
