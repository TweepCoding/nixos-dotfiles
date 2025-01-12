{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.apps.zen;
in
{
  options.apps.zen = with types; {
    enable = mkBoolOpt false "Enable/disable zen browser";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.zen-browser.packages."${pkgs.system}".default
    ];
  };
}
