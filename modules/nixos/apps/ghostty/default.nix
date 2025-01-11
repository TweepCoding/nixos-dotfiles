{ lib, ... }:
with lib;
with lib.custom;
let
  cfg = config.apps.ghostty;
in
{
  options.apps.ghostty = with types; {
    enable = mkBoolOpt true "Enable/disable ghostty";
  };
  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        theme = "catppuccin-mocha";
        font-size = 12;
        font-family = "JetbrainsMono Nerd Font Mono";
        window-decoration = false;
        background-opacity = 0.9;
        resize-overlay-position = "bottom-right";
      };
    };
  };
}
