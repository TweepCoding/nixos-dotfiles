{ lib, ... }:
with lib;
with lib.custom;
let
  cfg = config.rofi;
in
{
  options.rofi = with types; {
    enable = mkBoolOpt true "Enable/disable rofi";
  };
  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
    };
    home.file = {
      ".config/rofi" = {
        source = ./rofi;
        recursive = true;
      };
    };
  };
}
