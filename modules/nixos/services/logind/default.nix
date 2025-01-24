{ lib, config, ... }:
with lib;
with lib.custom;
let
  cfg = config.services.logind;
in
{
  options.services.logind = with types; {
    enable = mkBoolOpt false "Enable/disable logind not-sleep";
  };
  config = mkIf cfg.enable {
    services.logind = {
      lidSwitch = "ignore";
      lidSwitchDocked = "ignore";
    };
  };
}
