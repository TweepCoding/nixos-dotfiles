{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.apps.obs;
in
{
  options.apps.obs = with types; {
    enable = mkBoolOpt true "Enable/disable obs";
  };
  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
  };
}
