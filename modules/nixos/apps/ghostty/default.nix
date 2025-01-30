{ lib, config, ... }:
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
    home-manager.users.${config.user.name} = {
      programs.ghostty = {
        enable = true;
        enableFishIntegration = true;
        installVimSyntax = true;
        settings = {
          theme = "catppuccin-mocha";
          font-size = 12;
          font-family = "JetbrainsMono Nerd Font Mono";
          window-decoration = false;
          background-opacity = 0.8;
          resize-overlay-position = "bottom-right";
        };
      };
    };
  };
}
