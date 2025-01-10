{ lib, ... }:
with lib;
with lib.custom;
let
  cfg = config.ghostty;
in
{
  options.ghostty = with types; {
    enable = mkBoolOpt true "Enable/disable ghostty";
  };
  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        theme = "catppuccin-mocha";
        font-size = 12;
        font-family = userSettings.font;
        window-decoration = false;
        background-opacity = 0.9;
        resize-overlay-position = "bottom-right";
      };
    };
  };
}
