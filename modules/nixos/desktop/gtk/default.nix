{ config, lib, pkgs, ... }:
with lib;
with lib.custom;
let
  cfg = config.desktop.gtk;
in
{
  options.desktop.gtk = with types; {
    enable = mkBoolOpt false "Enable or disable gtk";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      gtk = {
        enable = true;
        theme = {
          name = "Catppuccin";
          package = pkgs.catppuccin-gtk;
        };
      };
      home.sessionVariables.GTK_THEME = "Catppuccin";
    };
  };
}
