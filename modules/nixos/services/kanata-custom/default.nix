{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.services.kanata-custom;
in
{
  options.services.kanata-custom = with types; {
    enable = mkBoolOpt false "Enable/disable kanata";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.kanata
    ];
    services.kanata = {
      enable = true;
    };
  };
}
