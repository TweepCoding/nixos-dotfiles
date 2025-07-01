{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.zellij;
in {
  options.apps.zellij = with types; {
    enable = mkBoolOpt true "Enable/disable zellij";
  };
  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      programs.zellij = {
        enable = true;
        settings = {
          theme = "catppuccin-macchiato";
        };
      };
    };
  };
}
