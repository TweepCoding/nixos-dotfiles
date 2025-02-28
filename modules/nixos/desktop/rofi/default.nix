{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.desktop.rofi;
in
{
  options.desktop.rofi = with types; {
    enable = mkBoolOpt true "Enable/disable rofi";
  };
  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      programs.rofi = {
        enable = true;
        plugins = [ pkgs.rofi-emoji ];
      };
      home.file = {
        ".config/rofi" = {
          source = ./rofi;
          recursive = true;
        };
      };
    };
  };
}
