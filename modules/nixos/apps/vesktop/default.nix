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
  cfg = config.apps.vesktop;
in
{
  options.apps.vesktop = with types; {
    enable = mkBoolOpt false "Enable vesktop";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.vesktop
      pkgs.kdePackages.xwaylandvideobridge
    ];
  };
}
