{ lib, config, ... }:
with lib;
with lib.custom;
let
  cfg = config.services.mpris;
in
{
  options.services.mpris = with types; {
    enable = mkBoolOpt false "Enable/disable mpris service";
  };
  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      services.mpris-proxy.enable = true;
    };
  };
}
