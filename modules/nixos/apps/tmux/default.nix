{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.apps.tmux;
in
{
  options.apps.tmux = with types; {
    enable = mkBoolOpt true "Enable/disable tmux";
  };
  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      plugins = [
        pkgs.tmuxPlugins.catppuccin
      ];
    };
  };
}
