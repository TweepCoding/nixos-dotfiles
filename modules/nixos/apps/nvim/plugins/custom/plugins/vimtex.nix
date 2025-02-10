{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.vimtex = {
      enable = true;
      texlivePackage = pkgs.texlive.combined.scheme-full;
    };
  };
}
