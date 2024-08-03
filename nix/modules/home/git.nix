{ pkgs, ... }:
{
  programs.git = {
    enable = true;

    userName = "Aabid Sofi";
    userEmail = "mailtoaabid01@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  # home.packages = [ pkgs.gh pkgs.git-lfs ];
}
