{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.suites.workstation;
in
{
  options.suites.workstation = with types; {
    enable = mkBoolOpt false "Enable the workstation suite";
  };

  config = mkIf cfg.enable {
    desktop.hypr.hyprland.enable = true;
    apps.zen.enable = true;
    apps.vesktop.enable = true;

    suites.common.enable = true;

    environment.systemPackages = with pkgs; [
      nemo
      xclip
      xarchiver
      grim
      grimblast
      hyprpolkitagent
      slurp
    ];
  };
}
